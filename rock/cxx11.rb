module Rock
    def self.default_loader_is_castxml?(os_package_resolver)
        os_package_resolver.has?('default_castxml')
    end

    # Offer the C++11 option only on systems where we either can install castxml
    # from the OS packages, or build it.
    #
    # But then, set it to true on OSes where it should. This is controlled by
    # stub osdep entries in defaults.osdeps
    def self.setup_cxx11_support(os_package_resolver, config)
        config.declare 'cxx11', 'boolean',
            default: 'no',
            doc: "whether C++11 should be enabled for Rock packages"
        config.get('cxx11')

        if !config.has_value_for?('typelib_cxx_loader')
            if default_loader_is_castxml?(os_package_resolver)
                config.set 'typelib_cxx_loader', 'castxml'
            else
                config.set 'typelib_cxx_loader', 'gccxml'
            end
        end
    end
end

