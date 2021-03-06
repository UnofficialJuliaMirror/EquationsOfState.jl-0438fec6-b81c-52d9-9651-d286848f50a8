# How to use `EquationsOfState` in Python?

It may be attempting for [Pythonistas](https://en.wiktionary.org/wiki/Pythonista)
to use this package in Python, without
writing too much code. Luckily, Julia provides such a feature.

1. First, install [`PyCall.jl`](https://github.com/JuliaPy/PyCall.jl), following their [instructions](https://github.com/JuliaPy/PyCall.jl/blob/master/README.md). Notice on macOS, that if you want to install Python from [`pyenv`](https://github.com/pyenv/pyenv), you may need to run

   ```shell
   env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.6.9
   ```

   in terminal to install your `python`, or else Julia will throw an

   ```julia
   ImportError: No module named site
   ```

   See [this issue](https://github.com/JuliaPy/PyCall.jl/issues/122) and [another issue](https://github.com/JuliaPy/PyCall.jl/issues/597) for details.

2. Install [`PyJulia`](https://pyjulia.readthedocs.io/en/stable/index.html) in Python. Please see [its official tutorial](https://pyjulia.readthedocs.io/en/stable/installation.html#step-2-install-pyjulia) for instructions.

3. Open a (an) Python (IPython) session, start playing!

   ```python
   In [1]: from julia import Unitful

   In [2]: from julia.EquationsOfState import *

   In [3]: from julia.EquationsOfState.Collections import *

   In [4]: from julia.EquationsOfState import *

   In [5]: Murnaghan(1, 2, 3.0, 4)
   Out[5]: <PyCall.jlwrap EquationsOfState.Collections.Murnaghan{Float64}(1.0, 2.0, 3.0, 4.0)>

   In [6]: result = lsqfit(
      ...:     PressureForm(),
      ...:     BirchMurnaghan3rd(1, 2, 3.0, 0),
      ...:     [1, 2, 3, 4, 5],
      ...:     [5, 6, 9, 8, 7],
      ...: )

   In [7]: result.v0, result.b0, result.bp0
   Out[7]: (1.1024687826913997, 29.308616965851673, 12.689089874230556)

   In [8]: from julia import Main

   In [9]: volumes = Main.eval("data[:, 1] .* UnitfulAtomic.bohr^3")

   In [10]: energies = Main.eval("data[:, 2] .* UnitfulAtomic.Ry")

   In [11]: Main.eval("EquationsOfState.NonlinearFitting.lsqfit(EquationsOfState.EnergyForm(), EquationsOfState.Collections.Murnaghan(224.445371 * UnitfulAtomic.bohr^3, 9.164446 * Unitful.GPa, 3.752432, -161.708856 * UnitfulAtomic.hartree), volumes, energies)")
   Out[11]: <PyCall.jlwrap EquationsOfState.Collections.Murnaghan{Unitful.Quantity{Float64,D,U} where U where D}(224.5018173532159 a₀^3, 8.896845579229117 GPa, 3.7238388137735674, -161.70884303138902 Eₕ)>
   ```

   where `data` is copied from Julia:

   ```python
   In [1]: data = Main.eval("""
      ...:    [
      ...:        159.9086 -323.4078898
                      ⋮          ⋮
      ...:        319.8173 -323.4105393
      ...:    ]
      ...:    """
      ...: )
   ```
