classdef Staff < Entity
    properties (Access = protected)
        name
        manager
    end
    
    methods (Access = public)
        function this = Staff(name, password, sid, isManager)
            this@Entity(sid, password);
            this.name = name;
            this.manager = isManager;
        end
        function isManager = isManager(this)
            isManager = this.manager;
        end
        
    end
end

