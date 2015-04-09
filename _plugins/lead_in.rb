module Jekyll
    module LeadIn
        def lead_in(input, type)
            if input.include? "<!--more-->"
                if type == "lead"
                    input.split("<!--more-->").first
                elsif type == "remaining"
                    input.split("<!--more-->").last
                else
                    input
                end
            else
                input
            end
        end
    end
end

Liquid::Template.register_filter(Jekyll::LeadIn)