function applied_load = member_check(A,L,r,lengthvec,val,accuracy,varargin)
failure = 0;
max_loads = 432.109*lengthvec.^-1.5061;
max_loads = max_loads.*(lengthvec./(lengthvec-1));  %uncertainty adjustment
if accuracy == .5; %rough accuracy run to establish baseline value
    applied_load = 4.5;
else new_max = varargin{1};
    applied_load = new_max-.51; %backs off more than one full iteration for a more accurate run
end
while ~failure      %increases the load until the truss fails
    L(1,r+val) = applied_load;
    T = (A^-1)*(L');   %T is the tension in each member
    support_forces = (T(end-2:end))';
    T = T(1:end-3)';
    if any((-1*T)>=max_loads)    %if any of the compression loads exceed the member's limit
        failure = 1;
    else applied_load = applied_load + accuracy;
    end
end

member_uncertainty = (289*(lengthvec).^-2.5061);
failed_member = find(max((T*-1)-max_loads>0)==((T*-1)-max_loads>0));
failure_uncertainty_percent = member_uncertainty(failed_member)/lengthvec(failed_member);

if accuracy ~= .5
    disp('\% EK301, Section A1, Group 18, 4/9/15')
    disp('\% Eric Loehle, ID U48711702')
    disp('\% Hannah Gibson, ID U46409674')
    disp('\% Brad Miller, ID U90274486')
    disp('\% DATE: 4/9/15')
    fprintf('Max load: %.2fN\n',applied_load)
    fprintf('     Uncertainty: %.2fN\n',applied_load*failure_uncertainty_percent);
    disp('Member forces in Newtons:')
    for i = 1:length(lengthvec)
        if T(i)>=0
            CorT = 'T';
        else CorT = 'C';
        end
        fprintf('m%i: %.3f (%s)\n',i,abs(T(i)),CorT)
        fprintf('     Uncertainty: %.2f\n',member_uncertainty(i));
    end
    disp('Reaction forces in Newtons:')
    disp('Sx1: 0')
    fprintf('Sy1: %.3f\n',support_forces(2))
    fprintf('Sy2: %.3f\n',support_forces(3))
    fprintf('Total cost: $%.2f\n',10*r+sum(lengthvec))
    fprintf('Theoretical max load/cost ratio in N/$: %.4f\n',applied_load/(10*r+sum(lengthvec)))
    fprintf('Failed member was member %i\n',failed_member)
end
    