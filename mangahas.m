clc;
clear;

disp('======================================');
disp('        Matrix Operations Program');
disp('======================================');

runProgram = true;

while runProgram

    % ===== Dimension Choice =====
    disp('Select matrix size option:');
    disp('1. Matrix A and B have the SAME size');
    disp('2. Matrix A and B have DIFFERENT sizes');

    sizeChoice = getValidatedMenuChoice(1,2);

    % ===== Matrix Input =====
    if sizeChoice == 1
        fprintf('\nEnter size for both matrices\n');

        rows = getPositiveInteger('Number of rows: ');
        cols = getPositiveInteger('Number of columns: ');

        fprintf('\nSize for both matrices is: %d x %d\n', rows, cols);

        A = getMatrixFixedSize('A', rows, cols);
        B = getMatrixFixedSize('B', rows, cols);
    else
        A = getMatrix('A');
        B = getMatrix('B');
    end

    % ===== Size Checks =====
    sameSize    = isequal(size(A), size(B));
    canMultiply = size(A,2) == size(B,1);
    squareA     = size(A,1) == size(A,2);
    squareB     = size(B,1) == size(B,2);

    keepMatrices = true;

    % ===== Operations Menu =====
    while keepMatrices
        disp('--------------------------------------');
        disp('Choose an operation:');

        if sameSize
            disp('1. Add Matrices (A + B)');
            disp('2. Subtract Matrices (A - B)');
            disp('3. Element-wise Multiply (A .* B)');
        else
            disp('1. Add Matrices (Unavailable)');
            disp('2. Subtract Matrices (Unavailable)');
            disp('3. Element-wise Multiply (Unavailable)');
        end

        if canMultiply
            disp('4. Matrix Multiplication (A * B)');
        else
            disp('4. Matrix Multiplication (Unavailable)');
        end

        disp('5. Transpose Matrix A');
        disp('6. Transpose Matrix B');

        if squareA
            disp('7. Determinant of Matrix A');
        else
            disp('7. Determinant of Matrix A (Unavailable)');
        end

        if squareB
            disp('8. Determinant of Matrix B');
        else
            disp('8. Determinant of Matrix B (Unavailable)');
        end

        if squareA
            disp('9. Eigenvalues & Eigenvectors of Matrix A');
        else
            disp('9. Eigenvalues & Eigenvectors of Matrix A (Unavailable)');
        end

        if squareB
            disp('10. Eigenvalues & Eigenvectors of Matrix B');
        else
            disp('10. Eigenvalues & Eigenvectors of Matrix B (Unavailable)');
        end

        disp('11. Enter new matrices');
        disp('12. Exit program');
        disp('--------------------------------------');

        menuChoice = getValidatedMenuChoice(1,12);

        switch menuChoice
            case 1
                if sameSize
                    disp('Result of A + B:');
                    disp(A + B);
                else
                    disp('Operation not allowed.');
                end

            case 2
                if sameSize
                    disp('Result of A - B:');
                    disp(A - B);
                else
                    disp('Operation not allowed.');
                end

            case 3
                if sameSize
                    disp('Result of A .* B:');
                    disp(A .* B);
                else
                    disp('Operation not allowed.');
                end

            case 4
                if canMultiply
                    disp('Result of A * B:');
                    disp(A * B);
                else
                    disp('Operation not allowed.');
                end

            case 5
                disp('Transpose of Matrix A:');
                disp(A.');

            case 6
                disp('Transpose of Matrix B:');
                disp(B.');

            case 7
                if squareA
                    fprintf('Determinant of Matrix A: %.2f\n', det(A));
                else
                    disp('Operation not allowed.');
                end

            case 8
                if squareB
                    fprintf('Determinant of Matrix B: %.2f\n', det(B));
                else
                    disp('Operation not allowed.');
                end

            case 9
                if squareA
                    disp('Eigenvalues of Matrix A:');
                    disp(eig(A));
                    disp('Eigenvectors of Matrix A:');
                    [V, ~] = eig(A);
                    disp(V);
                else
                    disp('Operation not allowed.');
                end

            case 10
                if squareB
                    disp('Eigenvalues of Matrix B:');
                    disp(eig(B));
                    disp('Eigenvectors of Matrix B:');
                    [V, ~] = eig(B);
                    disp(V);
                else
                    disp('Operation not allowed.');
                end

            case 11
                keepMatrices = false;

            case 12
                keepMatrices = false;
                runProgram = false;
                disp('Program ended.');
        end
    end
end

%% ===== Helper Functions =====

function n = getPositiveInteger(prompt)
    while true
        s = input(prompt,'s');
        n = str2double(s);

        if ~isnan(n) && isfinite(n) && n > 0 && n == fix(n)
            return;
        end
        disp('Invalid input. Please enter a positive whole number.');
    end
end

function choice = getValidatedMenuChoice(minVal, maxVal)
    while true
        s = input('Enter your choice: ','s');
        choice = str2double(s);

        if ~isnan(choice) && isfinite(choice) && choice == fix(choice) ...
                && choice >= minVal && choice <= maxVal
            return;
        end
        disp('Invalid choice. Please try again.');
    end
end

function M = getMatrix(name)
    fprintf('\nEnter size for Matrix %s\n', name);

    rows = getPositiveInteger('Number of rows: ');
    cols = getPositiveInteger('Number of columns: ');

    M = getMatrixFixedSize(name, rows, cols);
end

function M = getMatrixFixedSize(name, rows, cols)
    fprintf('\nEnter values for Matrix %s:\n', name);
    M = zeros(rows, cols);

    for r = 1:rows
        for c = 1:cols
            while true
                s = input(sprintf('%s(%d,%d): ', name, r, c),'s');
                val = str2double(s);

                if ~isnan(val) && isfinite(val)
                    M(r, c) = val;
                    break;
                end
                disp('Invalid input. Please enter a numeric value.');
            end
        end
    end
end
