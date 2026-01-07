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
    sizeChoice = input('Enter your choice (1 or 2): ');

    if sizeChoice ~= 1 && sizeChoice ~= 2
        disp('Invalid choice. Please try again.');
        continue;
    end

    % ===== Matrix Input =====
    if sizeChoice == 1
        fprintf('\nEnter size for both matrices\n');
        A = getMatrix('A');
        B = getMatrixSameSize('B', size(A));
    else
        A = getMatrix('A');
        B = getMatrix('B');
    end

    % ===== Size Check =====
    sameSize = isequal(size(A), size(B));

    if ~sameSize
        fprintf('\nWARNING: Matrices have different sizes.\n');
        fprintf('Matrix A: %d x %d\n', size(A,1), size(A,2));
        fprintf('Matrix B: %d x %d\n', size(B,1), size(B,2));
        fprintf('Addition and element-wise multiplication are disabled.\n\n');
    end

    keepMatrices = true;

    % ===== Operations Menu =====
    while keepMatrices
        disp('--------------------------------------');
        disp('Choose an operation:');

        if sameSize
            disp('1. Add Matrices (A + B)');
            disp('2. Element-wise Multiply (A .* B)');
        else
            disp('1. Add Matrices (Unavailable)');
            disp('2. Element-wise Multiply (Unavailable)');
        end

        disp('3. Transpose Matrix A');
        disp('4. Transpose Matrix B');
        disp('5. Enter new matrices');
        disp('6. Exit program');
        disp('--------------------------------------');

        menuChoice = input('Enter your choice (1–6): ');

        switch menuChoice
            case 1
                if sameSize
                    disp('Result of A + B:');
                    disp(addMatrix(A, B));
                else
                    disp('Operation not allowed.');
                end

            case 2
                if sameSize
                    disp('Result of A .* B:');
                    disp(multiplyMatrix(A, B));
                else
                    disp('Operation not allowed.');
                end

            case 3
                disp('Transpose of Matrix A:');
                disp(getTranspose(A));

            case 4
                disp('Transpose of Matrix B:');
                disp(getTranspose(B));

            case 5
                keepMatrices = false;

            case 6
                keepMatrices = false;
                runProgram = false;
                disp('Program ended.');

            otherwise
                disp('Invalid choice. Try again.');
        end
    end
end

%% ===== Helper Functions =====

function M = getMatrix(name)
    fprintf('\nEnter size for Matrix %s\n', name);

    rows = input('Number of rows: ');
    cols = input('Number of columns: ');

    if rows <= 0 || cols <= 0 || rows ~= fix(rows) || cols ~= fix(cols)
        error('Rows and columns must be positive whole numbers.');
    end

    fprintf('Enter values for Matrix %s:\n', name);
    M = zeros(rows, cols);

    for r = 1:rows
        for c = 1:cols
            val = input(sprintf('%s(%d,%d): ', name, r, c));
            if isempty(val) || ~isnumeric(val)
                error('Values must be numbers.');
            end
            M(r, c) = val;
        end
    end
end

function M = getMatrixSameSize(name, matSize)
    rows = matSize(1);
    cols = matSize(2);

    fprintf('\nMatrix %s will be %d x %d\n', name, rows, cols);
    fprintf('Enter values for Matrix %s:\n', name);

    M = zeros(rows, cols);

    for r = 1:rows
        for c = 1:cols
            val = input(sprintf('%s(%d,%d): ', name, r, c));
            if isempty(val) || ~isnumeric(val)
                error('Values must be numbers.');
            end
            M(r, c) = val;
        end
    end
end

function C = addMatrix(A, B)
    C = A + B;
end

function C = multiplyMatrix(A, B)
    C = A .* B;
end

function T = getTranspose(A)
    T = A.';
end
