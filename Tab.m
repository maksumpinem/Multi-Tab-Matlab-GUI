classdef Tab < handle
    properties
        TabIndex;
        Button;
        Container;
        LocalHandles;
        Documentation;
    end
    
    methods
        function obj = Tab(parentHandles,ParentContainerTag, button, container, tabFigure, tabDocumentation, tabIndex)
            tabHandles = guidata(tabFigure);
            
            % Menghilangkan border dari tombol tab
            buttons_jobj = findjobj(button);
            buttons_jobj.borderPainted = 0;

            % Field output dihilangkan dari handles tab agar saat di
            % gabungkan tidak menimpa field output dari handles utama.
            tabHandles = rmfield(tabHandles, 'output');
            
            obj.Documentation = tabDocumentation;
            obj.TabIndex      = tabIndex;
            obj.Button        = button;
            obj.Container     = tabHandles.(container);
            obj.LocalHandles  = catstruct(parentHandles, tabHandles);      
            
            obj.Container.Parent = parentHandles.(ParentContainerTag);
            if obj.TabIndex > 1
                obj.Container.Visible = 'off';
            end
        end
    end
end

