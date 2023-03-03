module FlashHelper
    def css_for_flash_key(flash_key)
        case flash_key.to_sym
        when :error
            "bg-red-100 text-red-700"
        when :success
            "bg-green-100 text-green-700"
        when :notice
            "bg-blue-100 text-blue-700"
        else
            "bg-blue-100 text-blue-700"
        end
    end
end
