classdef TabStrip < handle
    properties
        Tabs;
        LastSelectedTab;
        SelectedTabColor;
        NotSelectedTabColor;
        ParentFigure;
    end
    
    methods
        % Contructor akan membuat object tab sebanyak jumlah dari anggota
        % tagFigures untuk object tabStrip
        function obj = TabStrip(parentHandles, ParentContainerTag, tabFigures, tabContainerTags,...
                                tabButtons, selectedTabColor, notSelectedTabColor, tabDocumentations)                 
            % Inisialisasi fields object TabStrip
            obj.LastSelectedTab     = 1;
            obj.SelectedTabColor    = selectedTabColor;
            obj.NotSelectedTabColor = notSelectedTabColor;
            obj.ParentFigure        = parentHandles.output;
            
            % Membuat object Tab sebanyak jumlah anggota tabFigures
            obj.Tabs = cell(1, numel(tabFigures));
            for i=1:numel(tabFigures)
                obj.Tabs(i) = {Tab(parentHandles, ParentContainerTag, tabButtons{i}, tabContainerTags{i}, tabFigures{i}, tabDocumentations{i}, i)};
                close(tabFigures{i});
            end
        end
        
        % Fungsi ini akan menampilkan container tab yang sedang dipilih dan
        % meng-hide-kan container tab yang terkahir kali dipilih. Kemudian
        % handles akan diganti menjadi handles tab yang sedand dipilih.
        function obj = ShowTab(obj, tabIndex)
            if(tabIndex ~= obj.LastSelectedTab)
                % Update handles menjadi handles tab yang dipilh
                guidata(obj.ParentFigure, obj.Tabs{tabIndex}.LocalHandles);
                
                % Ubah warna tombol tab yang sedang dipilih
                tabButton                 = obj.Tabs{tabIndex}.Button;
                tabContainer              = obj.Tabs{tabIndex}.Container;
                set(tabButton, 'BackgroundColor', obj.SelectedTabColor, 'ForegroundColor', obj.NotSelectedTabColor);
                set(tabContainer, 'Visible', 'on');

                % Ubah warna tombol tab yang tidak dipilih menjadi warna dasar
                tabButton                 = obj.Tabs{obj.LastSelectedTab}.Button;
                tabContainer              = obj.Tabs{obj.LastSelectedTab}.Container;    
                set(tabButton, 'BackgroundColor', obj.NotSelectedTabColor, 'ForegroundColor', obj.SelectedTabColor);
                set(tabContainer, 'Visible', 'off');
                         
                % Update field LastSelectedTab menjadi nomor tab yang
                % sekarang dipilih
                obj.LastSelectedTab = tabIndex;
            end
        end
        
        function obj = AddTab(obj, parentHandles, mainContainerTag, tabButton, tabFigure, tabContainer) 
            obj.Tabs(numel(obj.Tabs)+1) = Tab(parentHandles, mainContainerTag, tabButton, tabContainer, tabFigure);
        end
    end
    
end

