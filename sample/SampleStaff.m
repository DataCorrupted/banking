stf1 = Staff("Jhon Doe", "4156asd", "12323432", 0);
stf2 = Staff("admin", "12345678", "69850764", 1);
stf3 = Staff("Dummy Person", "asdlf", "24324545", 0);

sampleStaffSystem = StaffSystem([stf1; stf2; stf3]);

result = [stf1.isManager(); stf2.isManager(); stf3.isManager(); sampleStaffSystem.getNum()];
if (result == [0; 1; 0; 3])
    fprintf('Staff samples created!\n');
else
    fprintf('Staff samples test failed!\n');
end