classdef TicketSystem < handle
    properties (Access = private)
        head
        tail
        called
    end

    methods (Access = private)
        function [this, status] = voidTicket(this)
            status = Status.TicketInvalid;
            this.head = this.head + 1;
            this.called = 0;
            status = Status.TicketVoided;
        end
    end

    methods (Access = public)

        function this = TicketSystem()
            this.head = 0;
            this.tail = 0;
            this.called = 0;
        end

        function [this, status] = takeTicket(this)
            this.tail = this.tail + 1;
            status = Status.TicketTaken;
        end

        function [this, status] = useTicket(this)
            status = Status.TicketInvalid;
            if (this.head < this.tail)
                status = Status.Successful;
                this.head = this.head + 1;
                this.called = 0;
            end
        end

        function [this, status] = callTicket(this)
            if (this.head > this.tail)
                status = Status.TicketDepleted;
                return
            end
            this.called = this.called + 1;
            status = Status.TicketCalled;
            if (this.called > 3)
                [this, status] = this.voidTicket();
            end
        end

        function tail = getTail(this)
            tail = this.tail;
        end

        function head = getHead(this)
            head = this.head;
        end
    end


end