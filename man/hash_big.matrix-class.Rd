% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hash_big.R
\docType{class}
\name{hash_big.matrix-class}
\alias{hash_big.matrix-class}
\alias{hash_big.matrix}
\alias{as.hash_big.matrix}
\alias{attach.hash_big.matrix}
\title{Class "hash_big.matrix": big matrix with a md5 hash reference}
\usage{
as.hash_big.matrix(x, backingpath = "bp", silence = TRUE, ...)

attach.hash_big.matrix(x, backingpath = "bp")
}
\arguments{
\item{x}{A matrix, vector, or data.frame for \code{\link[bigmemory:big.matrix]{bigmemory::as.big.matrix()}}.}

\item{backingpath, ...}{Passed to \code{\link[bigmemory:big.matrix]{bigmemory::as.big.matrix()}}.}

\item{silence}{Suppress messages?}
}
\description{
\code{hash_big.matrix} class is a modified class from \code{\link[bigmemory:big.matrix-class]{bigmemory::big.matrix-class()}}. Its purpose is to
help users operate big matrices within hard disk in a reusable way, so that the large matrices do not consume
too much memory, and the matrices can be reused for the next time.
Comparing with \code{\link[bigmemory:big.matrix-class]{bigmemory::big.matrix-class()}}, the major enhancement of \code{hash_big.matrix} class
is that the backing files are, by default, stored in a permanent place, with the md5 of the object as the file
name. With this explicit name, \code{hash_big.matrix} objects can be easily reloaded into workspace every time.
}
\section{Functions}{
\itemize{
\item \code{as.hash_big.matrix}: Create a \code{hash_big.matrix} object from a matrix.

\item \code{attach.hash_big.matrix}: Attach a \code{hash_big.matrix} object from the backing file to the workspace.
}}

\section{Slots}{

\describe{
\item{\code{md5}}{The md5 value of the matrix.}

\item{\code{address}}{Inherited from \code{big.matrix}.}
}}

