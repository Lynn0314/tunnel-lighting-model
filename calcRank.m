function [pop,front] = calcRank(pop)

    obj         = [pop(:).objective];
    domMat      = calcDominationMatrix(obj); % domination matrix for efficiency



    N = length(pop);    %popsize
    ind = repmat(struct('np',0, 'sp', []),[1,N]);
    
    
    % Compute np and sp of each indivudal
    for p = 1:N-1
        for q = p+1:N
            if(domMat(p, q) == 1)          % p dominate q
                ind(q).np = ind(q).np + 1;
                ind(p).sp = [ind(p).sp , q];
            elseif(domMat(p, q) == -1)     % q dominate p
                ind(p).np = ind(p).np + 1;
                ind(q).sp = [ind(q).sp , p];
            end
        end
    end
    
    % The first front(rank = 1)
    front(1).f = [];    % There are only one field 'f' in structure 'front'.
                        % This is intentional because the number of individuals
                        % in the front is difference.
    for i = 1:N
        if( ind(i).np == 0 )
            pop(i).rank = 1;
            front(1).f = [front(1).f, i];
        end
    end
    
    
    
    % Calculate pareto rank of each individuals, viz., pop(:).rank 
    fid = 1;        %pareto front ID
    while( ~isempty(front(fid).f) )
        Q = [];
        for p = front(fid).f
            for q = ind(p).sp
                ind(q).np = ind(q).np -1;
                if( ind(q).np == 0 )
                    pop(q).rank = fid+1;
                    Q = [Q, q];
                end
            end
        end
        fid = fid + 1;
        front(fid).f = Q;
    end
    front(fid) = [];    % delete the last empty front set
end

function domMat = calcDominationMatrix(obj)
    N       = size(obj, 2);
    numObj  = size(obj, 1);
    domMat  = zeros(N, N);
    for p = 1:N-1
        for q = p+1:N
            pdomq = false;
            qdomp = false;
            for i = 1:numObj
                if( obj(i,p) < obj(i,q) )         % objective function is minimization!
                    pdomq = true;
                elseif(obj(i,p) > obj(i,q))
                    qdomp = true;
                end
            end
            if( pdomq && ~qdomp )
                domMat(p, q) = 1;
            elseif(~pdomq && qdomp )
                domMat(p, q) = -1;
            end
        end
    end
    domMat = domMat - domMat';
end