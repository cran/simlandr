% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/batch_simulation.R
\name{modified_simulation}
\alias{modified_simulation}
\alias{batch_simulation}
\title{Do the batch simulation}
\usage{
modified_simulation(sim_fun, ele_list, default_list, bigmemory = TRUE, ...)

batch_simulation(arg_grid, sim_fun, default_list, bigmemory = TRUE, ...)
}
\arguments{
\item{sim_fun}{The simulation function. See \code{\link[=sim_fun_test]{sim_fun_test()}}
for an example.}

\item{ele_list}{An \code{ele_list} object generated by \code{\link[=fill_in_struct]{fill_in_struct()}}.}

\item{default_list}{A list of default values for \code{sim_fun}.}

\item{bigmemory}{Use \code{\link[=hash_big.matrix-class]{hash_big.matrix-class()}} to store large matrices?}

\item{...}{Other parameters passed to \code{sim_fun}}

\item{arg_grid}{An \code{arg_grid} object. See \code{\link[=make_arg_grid]{make_arg_grid()}}.}
}
\value{
A \code{batch_simulation} object, also a data frame.
The first column, \code{var}, is a list of
\code{ele_list} that contains all the variables; the second to the second
last columns are the values of the variables; the last column is the
output of the simulation function.
}
\description{
This is the main function for the batch simulation.
}
\section{Functions}{
\itemize{
\item \code{modified_simulation}: Modify a single simulation.
}}

\examples{
batch_arg_set_grad <- new_arg_set()
batch_arg_set_grad <- batch_arg_set_grad \%>\%
  add_arg_ele(
    arg_name = "parameter", ele_name = "a",
    start = -6, end = -1, by = 1
  )
batch_grid_grad <- make_arg_grid(batch_arg_set_grad)
batch_output_grad <- batch_simulation(batch_grid_grad, sim_fun_grad,
  default_list = list(
    initial = list(x = 0, y = 0),
    parameter = list(a = -4, b = 0, c = 0, sigmasq = 1)
  ),
  length = 1e2,
  seed = 1614,
  bigmemory = FALSE
)
print(batch_output_grad)
}
