module PlutoUIExtra

using Reexport
@reexport using PlutoUI
export Sidebar

include("sidebar.jl")
include("slider.jl")
include("select.jl")
include("radio.jl")
include("textfield.jl")


export bindobs, bindobs_

macro bindobs(def::Symbol, element)
    defraw = Symbol(def, :____raw)
    quote
        b = @bind $defraw $element
        Observable = Base.loaded_modules[Base.PkgId(Base.UUID("510215fc-4207-5dde-b226-833fc4488ee2"), "Observables")].Observable
        $(esc(def)) = Observable($(esc(defraw)))
        b
    end
end

macro bindobs_(def::Symbol)
    defraw = Symbol(def, :____raw)
    esc(:($def[] = $defraw; nothing))
end

end
