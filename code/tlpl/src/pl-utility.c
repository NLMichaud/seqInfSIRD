#include <R.h>
#include <Rmath.h>
#include "pl-utility.h"

/* Particle learning sufficient statistic update */
void suff_stat_update(const int *nRxns, const int *anRxnCount, const int *anY, const int *anHazardPart, 
                      double *adHyper) 
{
    int i,j;
    int o1=*nRxns,o2=2**nRxns,o3=3**nRxns; // offsets
    for (i=0; i<*nRxns; i++) 
    {
        adHyper[i   ] += anY[i];               // Beta (alpha)        - observations
        adHyper[i+o1] += anRxnCount[i]-anY[i]; // Beta (beta)         - unobserved
        adHyper[i+o2] += anRxnCount[i];        // Gamma shape (alpha) - transitions
        adHyper[i+o3] += anHazardPart[i];      // Gamma rate (beta)   - expected transitions
    }
}


void sample_p(const int *nLength, const double *adParameter, double *adBetas)
{
    int i;
    for (i=0; i<*nLength; i++) 
    {
        GetRNGstate();
        adBetas[i] = rbeta(adParameter[i], adParameter[i + *nLength]);
        PutRNGstate();
    }
}

void sample_theta(const int *nLength, const double *adParameter, double *adGammas)
{
    int i;
    for (i=0; i<*nLength; i++)
    {
        GetRNGstate();
        adGammas[i] = rgamma(adParameter[i], adParameter[i + *nLength]);
        PutRNGstate();
    }
}


