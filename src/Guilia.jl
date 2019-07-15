module Guilia

using Reexport
@reexport using TableWidgets
@reexport using Interact
@reexport using Blink
#@reexport using ProcessPhotometry
@reexport using JuliaDBMeta
@reexport using OnlineStats
@reexport using OffsetArrays
@reexport using ShiftedArrays
@reexport using Recombinase
@reexport using StructArrays
@reexport using IndexedTables
@reexport using WeakRefStrings

using Images
using BSON
using OrderedCollections


using FillArrays
using Observables
import Observables: AbstractObservable
using Recombinase: offsetrange



include("body.jl")
include("loading.jl")
include(joinpath("Photometry","generate_offsets.jl"))
include(joinpath("Photometry","combine_photometry.jl"))
include(joinpath("Photometry","sliding_mean.jl"))
include(joinpath("Photometry","regression.jl"))
include(joinpath("Photometry","construct.jl"))


 export launch
 export carica
 export generate_offsets, add_offsets
 export collect_traces
 export sliding_f0
 export regress_trace
 export construct_photo

end
