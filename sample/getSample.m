function [accSys, cusSys, stfSys, processor] = getSample()
    clear all

    SampleAccount;
    SampleCustomer;
    SampleStaff;

    accSys = sampleAccountSystem;
    cusSys = sampleCustomerSystem;
    stfSys = sampleStaffSystem;
    processor = Processor(accSys, cusSys, stfSys);
end