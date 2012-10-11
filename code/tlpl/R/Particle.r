# Functions for creating particles

# This particle complements the system created by test.system
test.particle = function(i=1)
{
    s = 3
    r = 8
    foundi = FALSE
    switch(i,
    {
        X = c(0,1,2)
        p = rep(.5,r)
        hyper = list()
        hyper$prob = list(a=rep(1,r), b=rep(1,r))
        hyper$rate = list(a=rep(1,r), b=rep(1,r))
        foundi=TRUE        
    })

    # Used in place of a default switch case
    if (!foundi) stop("Test system doesn't exist.")

    return(list(X=X,p=p,hyper=hyper))    
}


check.particles = function(part)
{
    stopifnot(!is.null(part),
              !is.null(part$hyper),
              !is.null(part$hyper$a),
              !is.null(part$hyper$b),
              !is.null(part$prob),
              !is.null(part$prob$a),
              !is.null(part$prob$b))

    stopifnot(length(part$hyper$rate$a) == length(part$hyper$rate$b),
              length(part$hyper$prob$a) == length(part$hyper$prob$b))
}


