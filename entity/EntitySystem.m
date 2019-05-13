classdef (Abstract) EntitySystem < handle
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
            this.deleteEntityFromPendingList(entity.getId());
        end

        function [this, status] = deleteEntity(this, id)
            i = this.getEntityIdx(id);
            if (i == 0)
                status = Status.InvalidEntity;
                return;
            end
            this.entities(i) = [];
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
        function isValid = isValid(this, id)
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
            if (~ this.isValid(id))
                retStr = Common.LogInIdInvalid;
                entity = [];
                return;
            end
            entity = this.getEntity(id);
            if (~ entity.passwordMatch(password))
                retStr = Common.LogInWrongPassword;
                entity = [];
                return;
            end
            retStr = Common.LogInSuccessful;
        end 
        
        % TODO: Requires lock or atom for thread safety.
        function entity = newId(this, len)
            entity = this.getKLenRandStr(len);
            while (this.getEntityIdx(entity) == 0)
                entity = this.getKLenRandStr(len);
            end
        end
        function str = getKLenRandStr(~, k)
            str = char(zeros(1, k));
            for i=1:k
                str(i) = num2str(randi(9));
            end
            str = string(str);
        end
    end
end

