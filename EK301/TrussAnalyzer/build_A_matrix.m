function [A,lengthvec] = build_A_matrix(A,r,c,connectmat,xvec,yvec)

lengthvec = zeros(1,c);
rowval2 = 0;
for rowval = 1:2*r
    if rowval == r+1
        rowval2 = rowval2-(r-1);
    else rowval2 = rowval2+1;
    end
        
    forces = find(connectmat(rowval2,:));       %vector of the forces at each joint
    for i = 1:length(forces)   
        member_coord_index = find(connectmat(:,forces(i))');        %returns the joints that the current member is connected to
        x_dist = xvec(member_coord_index(find(member_coord_index~=rowval2)))-xvec(rowval2);   %finds the distance in x
        y_dist = yvec(member_coord_index(find(member_coord_index~=rowval2)))-yvec(rowval2);   %finds the distance in y
        straight_dist = sqrt(x_dist^2+y_dist^2);
        if rowval <= r
            A(rowval,forces(i)) = x_dist/straight_dist;
        else 
            A(rowval,forces(i)) = y_dist/straight_dist;
        end
        lengthvec(forces(i)) = straight_dist;
    end
end
A(1,c+1) = 1;
A(r+1,c+2) = 1;
A(end,end) = 1;
end
