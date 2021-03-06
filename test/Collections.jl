using Test

using Unitful
using EquationsOfState
using EquationsOfState.Collections

@testset "Test EOS promotion" begin
    @test typeof(Murnaghan(1, 2, 3.0, 0)) === Murnaghan{Float64}
    @test typeof(BirchMurnaghan2nd(1, 2.0, 0)) === BirchMurnaghan2nd{Float64}
    @test typeof(BirchMurnaghan3rd(1, 2, 3.0, 0)) === BirchMurnaghan3rd{Float64}
    @test typeof(BirchMurnaghan4th(1, 2.0, 3, 4, 0)) === BirchMurnaghan4th{Float64}
    @test typeof(PoirierTarantola2nd(1, 2.0, 0)) === PoirierTarantola2nd{Float64}
    @test typeof(PoirierTarantola3rd(1, 2, 3.0, 0)) === PoirierTarantola3rd{Float64}
    @test typeof(PoirierTarantola4th(1, 2, 3, 4, 0)) === PoirierTarantola4th{Int}
    @test typeof(Vinet(1, 2, 3.0, 0)) === Vinet{Float64}
    @test typeof(AntonSchmidt(1, 2, 3.0, 0)) === AntonSchmidt{Float64}
    @test typeof(BreenanStacey(1, 2, 3.0, 0)) === BreenanStacey{Float64}
    @test Murnaghan(1, Int32(2), Int8(3), 0) === Murnaghan{Int}(1, 2, 3, 0)
    @test Murnaghan(1, 2 // 1, Int8(3), 0) === Murnaghan{Rational{Int}}(
        1 // 1,
        2 // 1,
        3 // 1,
        0 // 1,
    )
    @test BirchMurnaghan2nd(1, Int32(2), 0) === BirchMurnaghan2nd{Int}(1, 2, 0)
    @test BirchMurnaghan2nd(1 // 1, Int32(2), 0) === BirchMurnaghan2nd{Rational{Int}}(
        1 // 1,
        2 // 1,
        0 // 1,
    )
    @test BirchMurnaghan3rd(Int8(1), 2, 4, 0) === BirchMurnaghan3rd{Int}(1, 2, 4, 0)
    @test BirchMurnaghan3rd(Int8(1), 2 // 1, 4, 0) === BirchMurnaghan3rd{Rational{Int}}(
        1 // 1,
        2 // 1,
        4 // 1,
        0 // 1,
    )
    @test BirchMurnaghan4th(Int8(1), 2, 4, Int16(5), 6) === BirchMurnaghan4th{Int}(
        1,
        2,
        4,
        5,
        6,
    )
    @test BirchMurnaghan4th(
        Int8(1),
        2 // 1,
        4,
        Int16(5),
        6,
    ) === BirchMurnaghan4th{Rational{Int}}(1 // 1, 2 // 1, 4 // 1, 5 // 1, 6 // 1)
    @test Murnaghan{Float32}(Int(1), 2 // 1, Int8(3), Float64(4)) === Murnaghan(
        Float32(1.0),
        Float32(2.0),
        Float32(3.0),
        Float32(4.0),
    )
    @test Murnaghan{BigFloat}(Int(1), 2 // 1, Int8(3), Float64(4)) == Murnaghan(
        BigFloat(1.0),
        BigFloat(2.0),
        BigFloat(3.0),
        BigFloat(4.0),
    )
    @test BirchMurnaghan4th(
        Int8(1),
        2 // 1,
        big(4),
        Int16(5),
        6,
    ) == BirchMurnaghan4th{Rational{BigInt}}(1 // 1, 2 // 1, 4 // 1, 5 // 1, 6 // 1)
    @test BirchMurnaghan4th(
        Int8(1),
        2 // 1,
        big(4.0),
        Int16(5),
        6,
    ) == BirchMurnaghan4th{BigFloat}(1.0, 2.0, 4.0, 5.0, 6.0)
    @test BirchMurnaghan4th(
        Int8(1),
        2 // 1,
        big(4),
        Int16(5),
        6.0,
    ) == BirchMurnaghan4th{BigFloat}(1.0, 2.0, 4.0, 5.0, 6.0)
    @test PoirierTarantola2nd(Int8(1), 2, 3) === PoirierTarantola2nd{Int}(1, 2, 3)
    @test PoirierTarantola2nd(Int8(1), 2 // 1, 3) === PoirierTarantola2nd{Rational{Int}}(
        1 // 1,
        2 // 1,
        3 // 1,
    )
    @test PoirierTarantola3rd(Int8(1), 2, 3, Int16(4)) === PoirierTarantola3rd{Int}(
        1,
        2,
        3,
        4,
    )
    @test PoirierTarantola3rd(
        Int8(1),
        2 // 1,
        3 // 1,
        Int16(4),
    ) === PoirierTarantola3rd{Rational{Int}}(1 // 1, 2 // 1, 3 // 1, 4 // 1)
    @test PoirierTarantola4th(Int8(1), 2, 3, Int16(4), 5) === PoirierTarantola4th{Int}(
        1,
        2,
        3,
        4,
        5,
    )
    @test PoirierTarantola4th(
        Int8(1),
        2 // 1,
        3,
        Int16(4),
        5,
    ) === PoirierTarantola4th{Rational{Int}}(1 // 1, 2 // 1, 3 // 1, 4 // 1, 5 // 1)
    @test Vinet(Int8(1), 2, 3, Int16(4)) === Vinet{Int}(1, 2, 3, 4)
    @test Vinet(Int8(1), 2 // 1, 3, Int16(4)) === Vinet{Rational{Int}}(
        1 // 1,
        2 // 1,
        3 // 1,
        4 // 1,
    )
    @test AntonSchmidt(Int8(1), 2, 3, 0) === AntonSchmidt{Int}(1, 2, 3, 0)
    @test AntonSchmidt(Int8(1), 2 // 1, 3, 0) === AntonSchmidt{Rational{Int}}(
        1 // 1,
        2 // 1,
        3 // 1,
        0 // 1,
    )
    @test BreenanStacey(1, 2, 3, 0) === BreenanStacey{Int}(1, 2, 3, 0)
    @test BreenanStacey(1, 2, 3 // 1, 0) === BreenanStacey{Rational{Int}}(
        1 // 1,
        2 // 1,
        3 // 1,
        0 // 1,
    )
    @test typeof(Murnaghan(
        1 * u"angstrom^3",
        2 * u"eV/angstrom^3",
        3.0,
        4 * u"eV",
    )) === Murnaghan{Quantity{Float64}}
    @test typeof(Murnaghan(
        1 * u"angstrom^3",
        2 * u"eV/angstrom^3",
        3 // 2,
        4 * u"eV",
    )) === Murnaghan{Quantity{Rational{Int}}}
    @test typeof(BirchMurnaghan2nd(
        1 * u"angstrom^3",
        2 * u"eV/angstrom^3",
        3.0 * u"eV",
    )) === BirchMurnaghan2nd{Quantity{Float64}}
    @test typeof(BirchMurnaghan2nd(
        1 * u"angstrom^3",
        2 * u"eV/angstrom^3",
        3 // 1 * u"eV",
    )) === BirchMurnaghan2nd{Quantity{Rational{Int}}}
    @test typeof(BirchMurnaghan3rd(
        1 * u"angstrom^3",
        2 * u"GPa",
        4.0,
        3 * u"eV",
    )) === BirchMurnaghan3rd{Quantity{Float64}}
    @test typeof(BirchMurnaghan3rd(
        1 * u"angstrom^3",
        2 * u"GPa",
        4 // 1,
        3 * u"eV",
    )) === BirchMurnaghan3rd{Quantity{Rational{Int}}}
    @test typeof(BirchMurnaghan4th(
        1 * u"nm^3",
        2 * u"GPa",
        3.0,
        4 * u"1/GPa",
        5 * u"eV",
    )) === BirchMurnaghan4th{Quantity{Float64}}
    @test typeof(BirchMurnaghan4th(
        1 * u"nm^3",
        2 * u"GPa",
        3 // 1,
        4 * u"1/GPa",
        5 * u"eV",
    )) === BirchMurnaghan4th{Quantity{Rational{Int}}}
    @test typeof(PoirierTarantola2nd(
        1 * u"nm^3",
        2 * u"GPa",
        3.0 * u"eV",
    )) === PoirierTarantola2nd{Quantity{Float64}}
    @test typeof(PoirierTarantola2nd(
        1 * u"nm^3",
        2 * u"GPa",
        3 // 1 * u"eV",
    )) === PoirierTarantola2nd{Quantity{Rational{Int}}}
    @test typeof(PoirierTarantola3rd(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4.0 * u"eV",
    )) === PoirierTarantola3rd{Quantity{Float64}}
    @test typeof(PoirierTarantola3rd(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4 // 1 * u"eV",
    )) === PoirierTarantola3rd{Quantity{Rational{Int}}}
    @test typeof(PoirierTarantola4th(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4 * u"1/GPa",
        5.0 * u"eV",
    )) === PoirierTarantola4th{Quantity{Float64}}
    @test typeof(PoirierTarantola4th(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4 * u"1/GPa",
        5 // 1 * u"eV",
    )) === PoirierTarantola4th{Quantity{Rational{Int}}}
    @test typeof(Vinet(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4.0 * u"eV",
    )) === Vinet{Quantity{Float64}}
    @test typeof(Vinet(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4 // 1 * u"eV",
    )) === Vinet{Quantity{Rational{Int}}}
    @test typeof(AntonSchmidt(
        1 * u"nm^3",
        2 * u"GPa",
        3.0,
        0 * u"eV",
    )) === AntonSchmidt{Quantity{Float64}}
    @test typeof(AntonSchmidt(
        1 * u"nm^3",
        2 * u"GPa",
        3 // 1,
        0 * u"eV",
    )) === AntonSchmidt{Quantity{Rational{Int}}}
    @test typeof(BreenanStacey(
        1 * u"nm^3",
        2 * u"GPa",
        3.0,
        0 * u"eV",
    )) === BreenanStacey{Quantity{Float64}}
    @test typeof(BreenanStacey(
        1 * u"nm^3",
        2 * u"GPa",
        3 // 1,
        0 * u"eV",
    )) === BreenanStacey{Quantity{Rational{Int}}}
end

@testset "Test default EOS parameter `e0` and promotion" begin
    @test Murnaghan(1, 2, 3.0) === Murnaghan(1.0, 2.0, 3.0, 0.0)
    @test BirchMurnaghan2nd(1, 2.0) === BirchMurnaghan2nd(1.0, 2.0, 0.0)
    @test BirchMurnaghan3rd(1, 2, 3.0) === BirchMurnaghan3rd(1.0, 2.0, 3.0, 0.0)
    @test BirchMurnaghan4th(1, 2.0, 3, 4) === BirchMurnaghan4th(1.0, 2.0, 3.0, 4.0, 0.0)
    @test Vinet(1, 2, 3.0) === Vinet(1.0, 2.0, 3.0, 0.0)
    @test PoirierTarantola2nd(1, 2.0) === PoirierTarantola2nd(1.0, 2.0, 0.0)
    @test PoirierTarantola3rd(1, 2, 3.0) === PoirierTarantola3rd(1.0, 2.0, 3.0, 0.0)
    @test PoirierTarantola4th(1, 2, 3, 4) === PoirierTarantola4th(1, 2, 3, 4, 0)
    @test AntonSchmidt(1, 2, 3.0) === AntonSchmidt(1.0, 2.0, 3.0, 0.0)
    @test BreenanStacey(1, 2, 3.0) === BreenanStacey(1.0, 2.0, 3.0, 0.0)
    @test typeof(Murnaghan(
        1 * u"angstrom^3",
        2 * u"eV/angstrom^3",
        3,
    )) === Murnaghan{Quantity{Int}}
    @test typeof(Murnaghan(
        1 * u"angstrom^3",
        2 * u"eV/angstrom^3",
        3.0,
    )) === Murnaghan{Quantity{Float64}}
    @test typeof(BirchMurnaghan2nd(
        1 * u"nm^3",
        2 * u"GPa",
    )) === BirchMurnaghan2nd{Quantity{Int}}
    @test typeof(BirchMurnaghan2nd(
        1 * u"nm^3",
        2.0 * u"GPa",
    )) === BirchMurnaghan2nd{Quantity{Float64}}
    @test typeof(BirchMurnaghan3rd(
        1 * u"nm^3",
        2 * u"GPa",
        4,
    )) === BirchMurnaghan3rd{Quantity{Int}}
    @test typeof(BirchMurnaghan3rd(
        1 * u"nm^3",
        2 * u"GPa",
        4.0,
    )) === BirchMurnaghan3rd{Quantity{Float64}}
    @test typeof(BirchMurnaghan4th(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4 * u"1/GPa",
    )) === BirchMurnaghan4th{Quantity{Int}}
    @test typeof(BirchMurnaghan4th(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4.0 * u"1/GPa",
    )) === BirchMurnaghan4th{Quantity{Float64}}
    @test typeof(PoirierTarantola2nd(
        1 * u"nm^3",
        2 * u"GPa",
    )) === PoirierTarantola2nd{Quantity{Int}}
    @test typeof(PoirierTarantola2nd(
        1 * u"nm^3",
        2.0 * u"GPa",
    )) === PoirierTarantola2nd{Quantity{Float64}}
    @test typeof(PoirierTarantola3rd(
        1 * u"nm^3",
        2 * u"GPa",
        3,
    )) === PoirierTarantola3rd{Quantity{Int}}
    @test typeof(PoirierTarantola3rd(
        1 * u"nm^3",
        2 * u"GPa",
        3.0,
    )) === PoirierTarantola3rd{Quantity{Float64}}
    @test typeof(PoirierTarantola4th(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4 * u"1/GPa",
    )) === PoirierTarantola4th{Quantity{Int}}
    @test typeof(PoirierTarantola4th(
        1 * u"nm^3",
        2 * u"GPa",
        3,
        4.0 * u"1/GPa",
    )) === PoirierTarantola4th{Quantity{Float64}}
    @test typeof(Vinet(1 * u"nm^3", 2 * u"GPa", 3)) === Vinet{Quantity{Int}}
    @test typeof(Vinet(1 * u"nm^3", 2 * u"GPa", 3.0)) === Vinet{Quantity{Float64}}
    #@test typeof(AntonSchmidt(1u"nm^3", 2u"GPa", 3))
    #@test typeof(AntonSchmidt(1u"nm^3", 2u"GPa", 3.0))
    #@test typeof(BreenanStacey(1u"nm^3", 2u"GPa", 3))
    #@test typeof(BreenanStacey(1u"nm^3", 2u"GPa", 3.0)
end
