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
            case 1 % Addition
                if sameSize
                    Res = A + B;
                    disp('Result of A + B:');
                    disp(Res);
                    visualizeHeatmap(Res, 'Matrix Addition (A + B)');
                else
                    disp('Operation not allowed.');
                end

            case 2 % Subtraction
                if sameSize
                    Res = A - B;
                    disp('Result of A - B:');
                    disp(Res);
                    visualizeSurface(Res, 'Matrix Subtraction (A - B)');
                else
                    disp('Operation not allowed.');
                end

            case 3 % Element-wise Multiplication
                if sameSize
                    Res = A .* B;
                    disp('Result of A .* B:');
                    disp(Res);
                    visualizeSurface(Res, 'Element-wise Multiplication (A .* B)');
                else
                    disp('Operation not allowed.');
                end

            case 4 % Matrix Multiplication
                if canMultiply
                    Res = A * B;
                    disp('Result of A * B:');
                    disp(Res);
                    visualizeHeatmap(Res, 'Matrix Multiplication (A * B)');
                else
                    disp('Operation not allowed.');
                end

            case 5 % Transpose A
                Res = A.';
                disp('Transpose of Matrix A:');
                disp(Res);
                visualizeHeatmap(Res, 'Transpose of Matrix A');

            case 6 % Transpose B
                Res = B.';
                disp('Transpose of Matrix B:');
                disp(Res);
                visualizeHeatmap(Res, 'Transpose of Matrix B');

            case 7 % Det A
                if squareA
                    d = det(A);
                    fprintf('Determinant of Matrix A: %.2f\n', d);
                    visualizeDeterminant(A, 'Determinant of A');
                else
                    disp('Operation not allowed.');
                end

            case 8 % Det B
                if squareB
                    d = det(B);
                    fprintf('Determinant of Matrix B: %.2f\n', d);
                    visualizeDeterminant(B, 'Determinant of B');
                else
                    disp('Operation not allowed.');
                end

            case 9 % Eigen A
                if squareA
                    disp('Eigenvalues of Matrix A:');
                    disp(eig(A));
                    disp('Eigenvectors of Matrix A:');
                    [V, D] = eig(A);
                    disp(V);
                    visualizeEigen(A, V, D, 'Eigen Visualization Matrix A');
                else
                    disp('Operation not allowed.');
                end

            case 10 % Eigen B
                if squareB
                    disp('Eigenvalues of Matrix B:');
                    disp(eig(B));
                    disp('Eigenvectors of Matrix B:');
                    [V, D] = eig(B);
                    disp(V);
                    visualizeEigen(B, V, D, 'Eigen Visualization Matrix B');
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
        
        if menuChoice >= 1 && menuChoice <= 10
             disp('Visualization generated in a new figure window.');
             pause(0.5); 
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

%% ===== Visualization Functions =====

% 1. Heatmap (for Add, Mult, Transpose)
function visualizeHeatmap(M, titleStr)
    figure('Name', titleStr);
    imagesc(M);
    colormap(jet); 
    colorbar;
    title(titleStr);
    
    [rows, cols] = size(M);
    for r = 1:rows
        for c = 1:cols
            text(c, r, num2str(M(r,c), '%.2f'), ...
                'HorizontalAlignment', 'center', ...
                'Color', 'white', 'FontSize', 12, 'FontWeight', 'bold');
        end
    end
    xlabel('Columns');
    ylabel('Rows');
end

% 2. Surface Plot (for Subtraction, Element-wise Mult)
function visualizeSurface(M, titleStr)
    figure('Name', titleStr);
    surf(M);
    title(titleStr);
    colorbar;
    xlabel('Columns');
    ylabel('Rows');
    zlabel('Value');
    shading interp; 
    view(45, 30);   
end

% 3. Determinant (Geometric/Vector Area) 
function visualizeDeterminant(M, titleStr)
    figure('Name', titleStr);
    hold on;
    grid on;
    axis equal;
    
    % 2x2 Case
    if size(M,1) == 2 && size(M,2) == 2
        origin = [0, 0];
        vec1 = M(:,1);
        vec2 = M(:,2);
        
        % Fill area
        parallelogram = [origin; vec1'; (vec1+vec2)'; vec2'; origin];
        fill(parallelogram(:,1), parallelogram(:,2), 'c', 'FaceAlpha', 0.3);
        
        % Plot vectors
        q1 = quiver(0, 0, vec1(1), vec1(2), 0, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5);
        q2 = quiver(0, 0, vec2(1), vec2(2), 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);
        
        % --- Labels ---
        text(vec1(1), vec1(2), ' v_1', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'b');
        text(vec2(1), vec2(2), ' v_2', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'r');
        
        xlabel('X Axis'); ylabel('Y Axis');
        legend([q1, q2], {'Column Vector 1', 'Column Vector 2'}, 'Location', 'best');
        title({titleStr, ['Determinant (Area) = ' num2str(det(M), '%.2f')]});
        
    % 3x3 Case
    elseif size(M,1) == 3 && size(M,2) == 3
        origin = [0 0 0];
        % Plot vectors
        q1 = quiver3(0,0,0, M(1,1), M(2,1), M(3,1), 0, 'b', 'LineWidth', 2);
        q2 = quiver3(0,0,0, M(1,2), M(2,2), M(3,2), 0, 'r', 'LineWidth', 2);
        q3 = quiver3(0,0,0, M(1,3), M(2,3), M(3,3), 0, 'g', 'LineWidth', 2);
        
        % --- Proper Labels ---
        text(M(1,1), M(2,1), M(3,1), ' v_1', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'b');
        text(M(1,2), M(2,2), M(3,2), ' v_2', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'r');
        text(M(1,3), M(2,3), M(3,3), ' v_3', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'g');
        
        view(3);
        xlabel('X'); ylabel('Y'); zlabel('Z');
        legend([q1, q2, q3], {'Col 1', 'Col 2', 'Col 3'}, 'Location', 'best');
        title({titleStr, ['Determinant (Volume) = ' num2str(det(M), '%.2f')]});
        grid on;
        
    else
        % Fallback
        bar(eig(M));
        title([titleStr, ': Det is product of eigenvalues']);
        ylabel('Eigenvalues');
        xlabel('Index');
    end
    hold off;
end

% 4. Eigenvalues & Eigenvectors
function visualizeEigen(M, V, D, titleStr)
    figure('Name', titleStr);
    
    if size(M,1) == 2 && size(M,2) == 2
        hold on;
        axis equal;
        grid on;
        
        theta = linspace(0, 2*pi, 100);
        circle_pts = [cos(theta); sin(theta)];
        transformed_pts = M * circle_pts;
        
        plot(circle_pts(1,:), circle_pts(2,:), 'b--', 'LineWidth', 1);
        plot(transformed_pts(1,:), transformed_pts(2,:), 'r-', 'LineWidth', 2);
        
        origin = [0, 0];
        colors = ['g', 'm'];
        
        for i = 1:2
            val = D(i,i);
            vec = V(:,i);
            
            if ~isreal(val)
                val = real(val);
                vec = real(vec);
                title([titleStr, ' (Complex values detected, plotting real parts)']);
            else
                title(titleStr);
            end
            
            trans_vec = val * vec;
            quiver(origin(1), origin(2), trans_vec(1), trans_vec(2), 0, ...
                   'Color', [0.9 0.5 0], 'LineWidth', 3, 'MaxHeadSize', 0.5);
            
            quiver(origin(1), origin(2), vec(1), vec(2), 0, ...
                   'Color', colors(i), 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
        end
        
        legend({'Original Circle', 'Transformed Ellipse', 'Transformed Vec', 'Original Vec'});
        xlabel('X'); ylabel('Y');
        hold off;
    else
        compass(eig(M));
        title([titleStr, ' (Compass Plot of Eigenvalues)']);
    end
end