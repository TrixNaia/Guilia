function plot_attributes_w()
    wdg = Widget{:Plot_attributes}(output = Observable{Any}(("tick_orientation = :out, size = (809,500), fontfamily = \"bookman\"")))
    wdg[:Texts] = text_attributes()
    wdg[:Measures] = two_values_attributes()
    wdg[:Options] = optional_attributes()
    wdg[:Values] = value_attributes()
    output = Interact.@map join((&wdg[:Texts],&wdg[:Measures],&wdg[:Options],&wdg[:Values]),",")
    connect!(output,wdg.output)
    @layout! wdg hbox(
                    vbox(
                        :Texts,
                        :Measure
                        ),
                    hskip(1em),
                    :Options,
                    hskip(1em),
                    :Values
                    )

    return wdg
end

function text_attribute(nome::String)
    txt = Widgets.textbox("Insert title")
    res = map(txt) do val
        isempty(val) ? "$nome = \"\" " : "$nome = \"$val\""
    end
    wdg = Widget{:Size_attribute}(output = res)

    wdg[:attribute] = nome
    wdg[:value] = txt
    @layout! wdg vbox(:attribute,:value)
    return wdg
end

function text_attributes()
    wdg = Widget{:Text_attributes}(output = Observable{Any}(("xlabel = \"x\", ylabel = \"y\"")))
    wdg[:Title] = Guilia.text_attribute("title")
    wdg[:Xlabel] = Guilia.text_attribute("xlabel")
    wdg[:Ylabel] = Guilia.text_attribute("ylabel")
    text_output = Interact.@map join((&wdg[:Title], &wdg[:Xlabel], &wdg[:Ylabel]),",")

    connect!(text_output,wdg.output)
    @layout! wdg vbox(
                    :Title,
                    :Xlabel,
                    :Ylabel
                    )
    return wdg
end

function two_values_attribute(nome::String, first_val, second_val; default = ":auto")
    start = Widgets.spinbox(value = first_val,label = "1st")
    stop = Widgets.spinbox(value = second_val,label = "2nd")
    choice = togglecontent(vbox(start,stop))
    res = Interact.@map &choice ? ("$nome = ($(&start),$(&stop))") : ("$nome = ($default)")
    wdg = Widget{:Size_attribute}(output = res)

    wdg[:attribute] = nome
    wdg[:Min_value] = start
    wdg[:Max_value] = stop
    wdg[:Choice] = choice
    @layout! wdg vbox(:attribute,:Choice)
    return wdg
end

function two_values_attributes()
    wdg = Widget{:Measures_attributes}(output = Observable{Any}(("size = (809,500)")))
    wdg[:Fig_size] = Guilia.two_values_attribute("size",809,500;default = (809,500))
    wdg[:Xlims] = Guilia.two_values_attribute("xlims",0,20)
    wdg[:Ylims] = Guilia.two_values_attribute("ylims",0,20)
    measure_output = Interact.@map join((&wdg[:Fig_size], &wdg[:Xlims], &wdg[:Ylims]),",")
    connect!(measure_output,wdg.output)
    @layout! wdg vbox(
                    :Fig_size,
                    :Xlims,
                    :Ylims
                    )
    return wdg
end

function optional_attribute(nome::String, v::AbstractVector{Symbol})
    # opts = radiobuttons(v,label = "$nome")
    opts = dropdown(v,label = "$nome")
    res = Interact.@map "$nome = :$(&opts)"
    wdg = Widget{:Option_attribute}(output = res)

    wdg[:attribute] = nome
    wdg[:Choice] = opts
    @layout! wdg vbox(:Choice)
end

function optional_attribute(nome::String, v::AbstractVector{String})
    # opts = radiobuttons(v,label = "$nome")
    opts = dropdown(v,label = "$nome")
    res = Interact.@map "$nome = \"$(&opts)\""
    wdg = Widget{:Option_attribute}(output = res)

    wdg[:attribute] = nome
    wdg[:Choice] = opts
    @layout! wdg vbox(:Choice)
end

function optional_attributes()
    wdg = Widget{:Optional_attributes}(output = Observable{Any}(("tick_orientation = :out")))
    wdg[:Tick_dir] = Guilia.optional_attribute("tick_orientation",[:out,:in])
    wdg[:Grid] = Guilia.optional_attribute("grid",[:all,:none,:x,:y])
    wdg[:Legend] = Guilia.optional_attribute("legend",[:topleft,:topright,:bottomleft,:bottomright])
    wdg[:Font] = Guilia.optional_attribute("fontfamily",["bookman","avantgarde","courier","helvetica","newcenturyschlbk","palatino","times"])
    wdg[:BackGround] = Guilia.optional_attribute("background_color",[:white,:black,:grey,:red,:blue])
    optional_output = Interact.@map join((&wdg[:Tick_dir], &wdg[:Grid],&wdg[:Legend],&wdg[:Font],&wdg[:BackGround]),",")
    connect!(optional_output,wdg.output)
    @layout! wdg vbox(
                    :Tick_dir,
                    vskip(1em),
                    :Grid,
                    vskip(1em),
                    :Legend,
                    vskip(1em),
                    :Font,
                    vskip(1em),
                    :BackGround
                    )
    return wdg
end

function value_attribute(nome::String,val;default = :auto)
    amount = Widgets.spinbox(value = val)
    choice = togglecontent(vbox(amount))
    res = Interact.@map &choice ? ("$nome = $(&amount)") : ("$nome = ($default)")
    wdg = Widget{:Size_attribute}(output = res)

    wdg[:attribute] = nome
    wdg[:value] = amount
    wdg[:Choice] = choice
    @layout! wdg vbox(:attribute,:Choice)
    return wdg
end

function value_attributes()
    wdg = Widget{:Value_attributes}(output = Observable{Any}(("fillalpha = 0.3")))
    wdg[:FontSize] = Guilia.value_attribute("tickfontsize",10; default = 10)
    wdg[:LegendFontSize] = Guilia.value_attribute("legendfontsize",10; default = 10)
    wdg[:FillAlpha] = Guilia.value_attribute("fillalpha",0.3; default = 0.3)
    value_output = Interact.@map join((&wdg[:FontSize], &wdg[:LegendFontSize],&wdg[:FillAlpha]),",")
    connect!(value_output,wdg.output)
    @layout! wdg vbox(
                    :FontSize,
                    :LegendFontSize,
                    :FillAlpha
                    )
    return wdg
end
