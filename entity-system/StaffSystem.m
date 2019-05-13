classdef StaffSystem < EntitySystem
    
    properties (Constant)
        sIdLen = 8;
    end
    methods (Access = public)
        function this = StaffSystem(staffs)
            this@EntitySystem(staffs);
        end
        function this = addStaff(this, staff)
            this.addEntity(staff);
        end
        function [this, staff] = newStaff(this, name, password, isManager)
            sid = this.newId(this.sIdLen);
            staff = Staff(name, password, sid, isManager);
            this.addStaff(staff);
        end
    end
end

