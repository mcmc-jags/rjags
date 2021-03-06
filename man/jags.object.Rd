\name{jags.object}
\alias{variable.names.jags}
\alias{coef.jags}
\alias{list.samplers}
\title{Functions for manipulating jags model objects}
\description{
  A \code{jags} object represents a Bayesian graphical model
  described using the BUGS language. 
}
\usage{
\method{coef}{jags}(object, chain=1, \ldots)
\method{variable.names}{jags}(object, \ldots)
list.samplers(object)
}
\arguments{
  \item{object}{a \code{jags} model object}
  \item{chain}{chain number to query}
  \item{\ldots}{additional arguments to the call (ignored)}
}
\value{
  The \code{coef} function returns a list with an entry for each Node
  array that contains an unobserved Node. Elements corresponding to
  observed Nodes or deterministic Nodes are given missing values.

  The \code{variable.names} function returns a character vector of
  names of node arrays used in the model.

  The \code{list.samplers} function returns a named list with an entry
  for each Sampler used by the model.  Each list element is a character
  vector containing the names of stochastic Nodes that are updated
  together in a block. The names of the list elements indicate the
  sampling methods that are used to update each block.  Stochastic nodes
  that are updated by forward sampling from the prior are not listed.

} 
\examples{
  data(LINE)
  LINE$recompile()
  coef(LINE)
  variable.names(LINE)
  list.samplers(LINE)
}
\author{Martyn Plummer} \keyword{models}
