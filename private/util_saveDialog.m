function output = util_saveDialog
% Fungsi ini mereturnkan structure dengan field:
% IsValid
% String
    fileName = util_saveDialogUI;
    if(fileName.Valid)
        display(fileName);
        output = struct('IsValid', true, 'String', fileName.String);
    else
        output = struct('IsValid', false, 'String', 0);
        display(fileName);
    end