"""
Title: ganga_script.py
Author: Sam Eriksen
Date: August 2023
Description: Submission Script for running BACCARAT on Perlmutter
To Run:
    ganga ganga_script.py
"""

particle = 'po212'
baccarat_version = '6.3.3'
results_dir = '/global/cfs/projectdirs/lz/users/seriksen/LZ/ganga_example/results/BACCARAT_{0}/{1}'.format(baccarat_version,
                                                                                                           particle)
job_type = 'slurm' # 'slurm' or 'local'

n_jobs = 10
start_seed = 7000
splitter_env_vals = []
for i in range(start_seed, start_seed + n_jobs):
    variable_dict = {'BACCARAT_VERSION': baccarat_version,
                     'SEED': str(i),
                     'PARTICLE': particle,
                     'NBEAMON': '10',
                     'OUTPUT_DIR': './',
                     'OUTPUT_FILENAME': particle + '_',
                     'MACRO': particle + '.mac',
                     'RESULTS_DIR': results_dir,
                     }

    splitter_env_vals.append(variable_dict)

# Submit ganga jobs

j = Job()
j.application = Executable()
j.application.exe = File('worker_node_script.sh')
j.splitter = GenericSplitter()
j.splitter.attribute = 'application.env'
j.splitter.values = splitter_env_vals
j.inputfiles = [LocalFile('macros/{0}.mac'.format(particle))]

if job_type =='slurm':
    j.backend = Slurm()
    j.backend.extraopts = '--constraint=cpu --qos=shared --account=lz --mem=10GB --time=12:00:00'
elif job_type == 'local':
    j.backend = Local()
else:
    raise ValueError('Invalid job type: {0}'.format(job_type))

j.submit()