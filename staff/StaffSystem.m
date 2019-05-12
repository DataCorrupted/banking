classdef StaffSystem < EntitySystem
    
    methods (Access = public)
        function this = StaffSystem(staffs)
            this@EntitySystem(staffs);
        end
        function this = addStaff(this, staff)
            this.addEntity(staff);
        end
    end
end

