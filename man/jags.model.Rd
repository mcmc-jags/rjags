\name{jags.model}
\alias{jags.model}
\title{Create a JAGS model object}
\description{
  \code{jags.model} is used to create an object representing a
  Bayesian graphical model, specified with a BUGS-language description
  of the prior distribution, and a set of data.
}
\usage{
 jags.model(file, data, inits,
            n.chains = 1, n.adapt=1000, quiet=FALSE)
}
\arguments{
  \item{file}{the name of the file containing a description of the model in the
    JAGS dialect of the BUGS language.

    Alternatively, \code{file} can be a readable text-mode connection,
    or a complete URL.}
  \item{data}{a list or environment containing the data. Any numeric
    objects in \code{data} corresponding to node arrays used in
    \code{file} are taken to represent the values of observed nodes
    in the model.}
  \item{inits}{optional specification of initial values in the form of a
    list or a function (see \code{Initialization} below). If omitted,
    initial values will be generated automatically.  It is an error to
    supply an initial value for an observed node.}
  \item{n.chains}{the number of parallel chains for the model}
  \item{n.adapt}{the number of iterations for adaptation. See 
    \code{\link{adapt}} for details. If \code{n.adapt = 0} then no 
    adaptation takes place.}
  \item{quiet}{if \code{TRUE} then messages generated during compilation
    will be suppressed, as well as the progress bar during adaptation.}
}
\value{
  \code{jags.model} returns an object inheriting from class \code{jags}
  which can be used to generate dependent samples from the posterior
  distribution of the parameters
  
  An object of class \code{jags} is a list of functions that share a
  common environment. This environment encapsulates the state of the
  model, and the functions can be used to query or modify the model
  state.
  \item{ptr()}{Returns an external pointer to an object created by
    the JAGS library}
  \item{data()}{Returns a list containing the data that define
    the observed nodes in the model}
  \item{model()}{Returns a character vector containing the BUGS-language
    representation of the model}
  \item{state(internal=FALSE)}{Returns a list of length equal to the
    number of parallel chains in the model. Each element of the list is
    itself a list containing the current parameter values in that chain.
    if \code{internal=TRUE} then the returned lists also include the RNG
    names (\code{.RNG.name}) and states (\code{.RNG.state}).  This is
    not the user-level interface: use the \code{\link{coef.jags}} method
    instead.}
  \item{update(n.iter)}{Updates the model by \code{n.iter} iterations.
    This is not the user-level interface: use the
    \code{\link{update.jags}} method instead.}
}
\section{Initialization}{

  There are various ways to specify initial values for a JAGS model.
  If no initial values are supplied, then they will be generated
  automatically by JAGS. See the JAGS User Manual for
  details. Otherwise, the options are as follows:
  \enumerate{
    \item A list of numeric values. Initial values for a single chain
    may supplied as a named list of numeric values. If there are multiple
    parallel chains then the same list is re-used for each chain.
    
    \item A list of lists. Distinct initial values for each chain may be
    given as a list of lists. In this case, the list should have the same
    length as the number of chains in the model.
    
    \item A function.  A function may be supplied that returns a list of
    initial values.  The function is called repeatedly to generate initial
    values for each chain. Normally this function should call some random
    number generating functions so that it returns different values every
    time it is called. The function should either have no arguments, or
    have a single argument named \code{chain}. In the latter case, the
    supplied function is called with the chain number as argument. In this
    way, initial values may be generated that depend systematically on
    the chain number.
  }
}

\section{Random number generators}{

  Each chain in a model has its own random number generator (RNG).  RNGs
  and their initial seed values are assigned automatically when the
  model is created. The automatic seeds are calculated from the current
  time.

  If you wish to make the output from the model reproducible, you may
  specify the RNGs to be used for each chain, and their starting seeds
  as part of the \code{inits} argument (see \code{Initialization}
  above). This is done by supplementing the list of initial parameter
  values for a given chain with two additional elements named
  \dQuote{.RNG.name}, and \dQuote{.RNG.seed}:
  \describe{
    \item{\code{.RNG.name}}{a character vector of length 1. The names of
    the RNGs supplied in the base module are:
    \itemize{
      \item \dQuote{base::Wichmann-Hill}
      \item \dQuote{base::Marsaglia-Multicarry}
      \item \dQuote{base::Super-Duper}
      \item \dQuote{base::Mersenne-Twister}
    }
    If the lecuyer module is loaded, it provides \dQuote{lecuyer::RngStream}
    }
    \item{\code{.RNG.seed}}{a numeric vector of length 1 containing an
    integer value.}
  }
  
  Note that it is also possible to specify \dQuote{.RNG.state} rather than 
  \dQuote{.RNG.seed} - see for example the output of \code{\link{parallel.seeds}}
}
\author{Martyn Plummer}
\keyword{models}

