clc;
clear;

disp('======================================');
disp('        Matrix Operations Program');
disp('======================================');

runApp = true;

while runApp

    % Choose how matrix sizes relate
    disp('Select matrix dimension relationship:');
    disp('1. Matrices A and B have the SAME size');
    disp('2. Matrices A and B have DIFFERENT sizes');
    sizeChoice = input('Enter your choice (1 or 2): ');

    if sizeChoice ~= 1 && sizeChoice ~= 2
        disp('Invalid choice. Restarting input.');
        continue;
    end

    % Matrix input
    if sizeChoice == 1
        fprintf('\nEnter dimensions (shared by both matrices)\n');
        matrixA = getMatrixFromUser('A');
        matrixB = getMatrixWithFixedSize('B', size(matrixA));
    else
        matrixA = getMatrixFromUser('A');
        matrixB = getMatrixFromUser('B');
    end

    % Check if operations requiring equal size are allowed
    sameDimensions = isequal(size(matrixA), size(matrixB));

    if ~sameDimensions
        fprintf('\nWARNING: Matrices have different sizes.\n');
        fprintf('Matrix A: %d x %d\n', size(matrixA));
        fprintf('Matrix B: %d x %d\n', size(matrixB));
        fprintf('Addition and element-wise multiplication are disabled.\n\n');
    end

    reuseMatrices = true;

    % Operations menu
    while reuseMatrices
        disp('--------------------------------------');
        disp('Choose an operation:');

        if sameDimensions
            disp('1. A + B');
            disp('2. A .* B');
        else
            disp('1. A + B  [Unavailable]');
            disp('2. A .* B [Unavailable]');
        end

        disp('3. Transpose A');
        disp('4. Transpose B');
        disp('5. Enter new matrices');
        disp('6. Exit program');
        disp('--------------------------------------');

        menuChoice = input('Enter your choice (1–6): ');

        switch menuChoice
            case 1
                if sameDimensions
                    disp('Result:');
                    disp(addMatrices(matrixA, matrixB));
                else
                    disp('Operation not allowed.');
                end

            case 2
                if sameDimensions
                    disp('Result:');
                    disp(elementWiseMultiply(matrixA, matrixB));
                else
                    disp('Operation not allowed.');
                end

            case 3
                disp('Transpose of A:');
                disp(transposeMatrix(matrixA));

            case 4
                disp('Transpose of B:');
                disp(transposeMatrix(matrixB));

            case 5
                reuseMatrices = false;

            case 6
                reuseMatrices = false;
                runApp = false;
                disp('Program terminated.');

            otherwise
                disp('Invalid selection.');
        end
    end
end

%% ===== Helper Functions =====

function M = getMatrixFromUser(label)
    fprintf('\nEnter dimensions for Matrix %s\n', label);
    rows = input('Rows: ');
    cols = input('Columns: ');

    if ~isscalar(rows) || ~isscalar(cols) || rows <= 0 || cols <= 0 || ...
       rows ~= fix(rows) || cols ~= fix(cols)
        error('Dimensions must be positive integers.');
    end

    fprintf('Enter values for Matrix %s:\n', label);
    M = zeros(rows, cols);

    for r = 1:rows
        for c = 1:cols
            M(r, c) = input(sprintf('%s(%d,%d): ', label, r, c));
        end
    end
end

function M = getMatrixWithFixedSize(label, matrixSize)
    rows = matrixSize(1);
    cols = matrixSize(2);

    fprintf('\nMatrix %s size: %d x %d\n', label, rows, cols);
    M = zeros(rows, cols);

    for r = 1:rows
        for c = 1:cols
            M(r, c) = input(sprintf('%s(%d,%d): ', label, r, c));
        end
    end
end

function result = addMatrices(A, B)
    result = A + B;
end

function result = elementWiseMultiply(A, B)
    result = A .* B;
end

function T = transposeMatrix(A)
    T = A.';
end
