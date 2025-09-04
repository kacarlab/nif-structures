# Massive Nitrogenase Structure Prediction

![](nitrospace-pet.png)

## Summary

Nitrogenases are the only known enzymatic catalysts capable of Nitrogenase reduction.
While they are fundamental to close the nitrogen cycle, there are only a few structures
avaiable, corresponding to only 5 different organisms. Given the huge environmental
diversity of the organisms carrying these enzymes, we believe that knowing the structure
of the remaining Nitrogenases could be useful for future research.


In this repository, we provide the materials required to reproduce our *Nitrogenase
Structural Space DB*. 

## Contents

- **data**: All data that is used for specific analysis or generated from reading structures
and sequences.
- **figures**:
- **notebooks**: It contains notebooks for handling the different analysis, and to reproduce
the article figures.
- **pipeline**: It contains a *ploomber* pipeline, structures as bash scripts and jupyter notebooks,
to process the structures as they get out of the colabfold pipeline. I explain this pipeline below. 
- **preparation**: It contains notebooks used to organize the sequences for massive prediction.
- raw: The data, as it gets out of Colabfold. This data won't be included in the repository
- **sequences**: It contains the sequences that we use for structure prediction.
- **server**: It contains a streamlit app to allow users to interact with this data.
- **structures**: It contains the predicted structures. We note that we might not be able
to host all these structures in a Github repository.

## Preparation

There are a couple protocols:
- **bona-fide**. Just the standard AF2 protocol. It gives place to the "gold" data.
- **recycling**. Recycling MSA alignments. It is used to predict sequence variants. It gives place to the "silver" data.
We provide a "scripts" folder (´/preparation/scripts/´) containing the AF2 scripts that we used in our HPC cluster.

## Pipelines

### Post-prediction pipeline (/pipeline)

The pipeline aims to provide the same treatment to all the prediction files. We consider three steps:
- Alignment against a reference, to ease all further calculations.
- Renaming the chains, so all chains have the same name as the reference to which they were aligned.
- Clean the N and C tail regions with unreliable predictions.

To run the pipeline, you need to:
1. Copy the pipeline.yaml and env.yaml files from the pipeline.
2. Copy the reference.pdb that you want to use to align all the structures to.
3. Create a .input file containing all the files that you want to process. If a file is problematic, you
might just remove it from the list.
4. Load a Python environment with a ploomber, prody, and pandas installation.
5. Finally, run:

    ploomber build --entry-point pipeline.yaml


**WARNING**: You might need to modify the pipeline.yaml to match the location of your library:


    meta:
    source_loader:
        path: /wherever-you-cloned-the-repo/pipeline

    tasks:

### Structure sorting pipeline (/structures)

This other pipeline aims for a different goal: taking all the predictions, and unify their different aspects so
they become organized for the DB storage. One of the notebooks also carries out different calculations on the structures
to characterize them.


## Server


The server can be deployed locally, after the installation of the corresponding
libraries, using streamlit. 


    streamlit run nitrogenase-structural-space.py

We note, however, that the nitrogenase-structural-db.streamlit.com server is not
an exact match of this server, as we are using an S3 solution for storage (the whole
dataset is around 3.8GB).

## Files

PDB files are available at [Zenodo](10.5281/zenodo.13351063)
