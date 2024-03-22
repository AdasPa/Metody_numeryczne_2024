function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
    numer_indeksu = 193318;
    N = 8;
    % L1 = 1;
    % L2 = 3;
    % mod(L1,7)+1 = 2;
    % mod(L2,7)+1 = 4;

    Edges = [ 1 1 2 2 2 3 3 3 4 4 4 5 5 6 6 7 8;
              4 6 3 4 5 5 6 7 5 6 8 4 6 4 7 6 2];
    I = speye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
    sum_B = sum(B);
    A = spdiags(1./sum_B', 0, N, N);
    d = 0.85;
    
    b = ((1 - d) / N) * ones(N, 1);
    r = (I - (d * B * A)) \ b;
end
