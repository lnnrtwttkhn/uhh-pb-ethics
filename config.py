
def read_yaml(path):    
    import yaml
    with open(path, 'r') as stream:
        try:
            config = yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)
    return config


def get_sha(length=40):
    import git
    repo = git.Repo(search_parent_directories=True)
    sha = repo.head.object.hexsha
    sha_short = sha[0:length]
    return sha_short


def write_config(config):
    file = open('config.tex', 'w')
    for key, value in config.items():
        line = r'\newcommand\%s{%s}' % (key, value)
        file.write(line + '\n')
    file.close()

config = read_yaml(path='config.yml')
config['HeadSha'] = get_sha(length=6)
write_config(config)