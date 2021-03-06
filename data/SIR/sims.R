library(tlpl)
library(plyr)


# Generate data
## Set up SIR model
sys = sckm("sir", X=c(16000,100,0))
N = sum(sys$X)

## Simulate data
source("settings.R")
prior = list(prob=list(a=rep(50,sys$r), b=rep(950,sys$r)),
             rate=list(a=c(.5,.25)*100, b=rep(100,sys$r)))

# A function to produce a single simulation
sim.f = function()
{
  failed = TRUE
  
  try({

    somey = FALSE
    while(!somey) 
    {
      sys$X = as.numeric(rmultinom(1,N,sys$X/N))
      sys$theta = rgamma( sys$r, prior$rate$a, prior$rate$b)

      out = tau_leap(sys, n)
      out$sys = sys
      out$rates = sys$theta
      out$probs = rbeta( sys$r, prior$prob$a, prior$prob$b)
      out$y = cbind(rbinom(n, out$nr[,1], out$p[1]), 
                    rbinom(n, out$nr[,2], out$p[2]))

      somey = sum(out$y[1:5,1]>0)
    }

    }, silent=T)

  if (exists("out")) return(out) else { return(NA) }
}

# Apply the function n.sims times and return as a list
sims = rlply(n.sims, sim.f, 
             .progress = progress_text(style=ifelse(interactive(), 3, 1)))

# If a simulation had an error, resimulate
for (i in 1:n.sims)
{
  while(!is.list(sims[[i]])) sims[[i]] = sim.f()
}

save.image("sims.RData")

q(ifelse(interactive(),"ask","no"))

