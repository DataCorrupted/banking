classdef (Abstract) EntitySystem
    properties (Access = protected)
        entities
        entityNum
    end
    
    methods (Access = public)
        function this = EntitySystem(entities)
            this.entities = entities;
            [this.entityNum, ~] = size(entities);
        end
        
        function this = addEntity(this, entity)
            this.entities = [this.entities; entity];
            this.entityNum = this.entityNum + 1;
        end
        function [this, status] = deleteEntity(this, id)
            i = this.getEntityIdx(id);
            if (i == 0)
                status = Status.InvalidEntity;
                return;
            end
            if (i == 1)
                this.entities = this.entities(2:this.entityNum);
            else
            if (i == this.entityNum)
                this.entities = this.entities(1:this.entityNum - 1);
            else
                this.entities = [this.entities(1:i-1); 
                             this.entities(i+1:this.entityNum)];
            end
            end
            status = Status.Successful;
            this.entityNum = this.entityNum - 1;
        end

        function k = getEntityIdx(this, id)
            for i = 1:this.entityNum
                if (strcmp(this.entities(i).getId(), id))
                    k = i;
                    return
                end
            end
            k = 0;  % Failed. Such entity doesn't exist.
        end
        function isValid = isValidEntity(this, id)
            isValid = (this.getEntityIdx(id) ~= 0);
        end
        function entity = getEntity(this, uid)
            idx = this.getEntityIdx(uid);
            if (idx == 0)
                return
            end
            entity = this.entities(idx);
        end
        
        function [retStr, entity] = logIn(this, id, password)
            if (~ this.isValidEntity(id))
                retStr = Common.LogInIdInvalid;
                entity = [];
                return;
            end
            entity = this.getEntity(id);
            if (~ entity.passwordMatch(password))
                entity = [];
                retStr = Common.LogInWrongPassword;
                return;
            end
            retStr = Common.LogInSuccessful;
        end        
    end
end

