function adjacency_matrix(adj::AbstractMatrix, T::DataType=eltype(adj))
    m, n = size(adj)
    (m == n) || throw(DimensionMismatch("adjacency matrix is not a square matrix: ($m, $n)"))
    T.(adj)
end

adjacency_matrix(fg::FeaturedGraph, T::DataType=eltype(graph(fg))) = adjacency_matrix(graph(fg), T)

Zygote.@nograd adjacency_matrix

function degrees(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); dir::Symbol=:out)
    degrees(graph(fg), T; dir=dir)
end

function degree_matrix(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); dir::Symbol=:out)
    degree_matrix(graph(fg), T; dir=dir)
end

function inv_sqrt_degree_matrix(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); dir::Symbol=:out)
    inv_sqrt_degree_matrix(graph(fg), T; dir=dir)
end

function laplacian_matrix(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); dir::Symbol=:out)
    laplacian_matrix(graph(fg), T; dir=dir)
end

function normalized_laplacian(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); selfloop::Bool=false)
    normalized_laplacian(graph(fg), T; selfloop=selfloop)
end

function scaled_laplacian(fg::FeaturedGraph, T::DataType=eltype(graph(fg)))
    scaled_laplacian(graph(fg), T)
end

## Inplace operations

function laplacian_matrix!(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); dir::Symbol=:out)
    if fg.matrix_type == :adjm
        fg.graph .= laplacian_matrix(graph(fg), T; dir=dir)
        fg.matrix_type = :laplacian
    end
    fg
end

function normalized_laplacian!(fg::FeaturedGraph, T::DataType=eltype(graph(fg)); selfloop::Bool=false)
    if fg.matrix_type == :adjm
        fg.graph .= normalized_laplacian(graph(fg), T; selfloop=selfloop)
        fg.matrix_type = :normalized
    end
    fg
end

function scaled_laplacian!(fg::FeaturedGraph, T::DataType=eltype(graph(fg)))
    if fg.matrix_type == :adjm
        fg.graph .= scaled_laplacian(graph(fg), T)
        fg.matrix_type = :scaled
    end
    fg
end
