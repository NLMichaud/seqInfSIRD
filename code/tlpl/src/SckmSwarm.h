#include "Sckm.h"
#include "SckmParticle.h"

typedef struct SckmSwarm {
    int nParticles, nStates, nRxns, logWeights, normalizedWeights;
    double *dWeights;
    SckmParticle **aParticles;
} SckmSwarm;

SckmSwarm *newSckmSwarm(Sckm *sckm, int _nParticles,
                        int *_state,
                        double *_probA, double *_probB, double *_rateA, double *_rateB,
                        double *_prob, double *_rate);

void deleteSckmSwarm(SckmSwarm *swarm);
                        
int renormalize(SckmSwarm *swarm);

