# binder-tag

Code to accompany Liu B*, Stone OJ*, Pablo M*, Herron JC, Nogueira AT, Dagliyan O, Grimm JB, Lavis LD, Elston TC, Hahn KM. <i> Biosensors based on peptide exposure show single molecule conformations in live cells. </i> Cell 2021 (Forthcoming).

Initial release (v1.0.0):
[![badge](https://zenodo.org/badge/209335720.svg)]()

__Contains:__ code for ...
- analyzing clusters from single particle tracking (SPT) maps (`cluster_analysis`) (Figure 6).
- modeling and fitting cluster kinetics (`cluster_dynamics`) (Figure 6).
- analyzing regulatory kinetics from tagSrc/Binder SPT co-diffusion events (`kinetics_analysis`) (Figure 7).

Note: The cluster analysis pipeline requires diffusional dynamics to be completed, since we annotate the diffusional states along clustered tracks. However, the diffusional dynamics analysis can be done separately (and is in fact the variational Bayes SPT method from the Elf lab (Persson F et al. Nature Methods 2013) -- see (`diffusional_dynamics`).

__Does not contain:__ methods for detecting or fitting centroids of single particles from raw imaging data; methods for linking sets of centroids into tracks; methods for detecting the co-diffusion events.
