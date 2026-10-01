module FlashHelper
    def css_for_flash_key(flash_key)
        case flash_key.to_sym
        when :error, :danger
            "bg-rose-50 text-rose-800 ring-rose-200 dark:bg-rose-950 dark:text-rose-200 dark:ring-rose-900"
        when :success
            "bg-emerald-50 text-emerald-800 ring-emerald-200 dark:bg-emerald-950 dark:text-emerald-200 dark:ring-emerald-900"
        else
            "bg-white text-zinc-800 ring-zinc-200 dark:bg-zinc-900 dark:text-zinc-100 dark:ring-white/10"
        end
    end

    def flash_icon(flash_key)
        case flash_key.to_sym
        when :error, :danger then :alert
        when :success then :check
        else :info
        end
    end
end
