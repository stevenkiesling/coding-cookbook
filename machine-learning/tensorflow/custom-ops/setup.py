from setuptools import find_packages
from setuptools import setup
from setuptools.dist import Distribution

__version__ = '1.0.0'
REQUIRED_PACKAGES = [
    'tensorflow >= 1.13.1',
]
project_name = 'heatmap'

class BinaryDistribution(Distribution):
  """This class is needed in order to create OS specific wheels."""

  def has_ext_modules(self):
    return True

setup(
    name=project_name,
    version=__version__,
    description=('HeatMap is a custom op for TensorFlow'),
    author='Steven Kiesling',
    # Contained modules and scripts.
    packages=find_packages(),
    install_requires=REQUIRED_PACKAGES,
    # Add in any packaged data.
    include_package_data=True,
    zip_safe=False,
    distclass=BinaryDistribution,
    # PyPI package information.
    classifiers=[
        'Development Status :: 1 - Dev',
        'Intended Audience :: Developers',
        'Intended Audience :: Education',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: Apache Software License',
        'Programming Language :: Python :: 3.5',
        'Topic :: Scientific/Engineering :: Mathematics',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Topic :: Software Development :: Libraries',
    ],
    license='Apache 2.0',
    keywords='tensorflow custom op machine learning',
)