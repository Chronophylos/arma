params ["_position"];

_particle_emitter_0 = "#particlesource" createvehiclelocal _position;
_particle_emitter_0 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d", 8, 0, 40, 1], "", "Billboard", 1, 44, [0, 0, 0], [0, 0, 2.5], 1, 0.05, 0.04, 0.05, [3, 20], [[0.35, 0.35, 0.35, 0.6], [0.35, 0.35, 0.35, 0.75], [0.35, 0.35, 0.35, 0.45], [0.42, 0.42, 0.42, 0.28], [0.42, 0.42, 0.42, 0.16], [0.42, 0.42, 0.42, 0.09], [0.42, 0.42, 0.42, 0.06], [0.5, 0.5, 0.5, 0.02], [0.5, 0.5, 0.5, 0]], [1, 0.55, 0.35], 0.3, 0.2, "", "", "", 0, false, 0, [[0, 0, 0, 0]]];
_particle_emitter_0 setParticleRandom [22, [3, 3, 0.15], [0.25, 0.25, 0.5], 0.5, 0, [0, 0, 0, 0.06], 0, 0, 0.5, 0];
_particle_emitter_0 setParticleCircle [1, [0, 0, 0]];
_particle_emitter_0 setParticleFire [0, 0, 0];
_particle_emitter_0 setDropInterval 0.04;

_particle_emitter_1 = "#particlesource" createvehiclelocal _position;
_particle_emitter_1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 10, 32, 1], "", "Billboard", 1, 1.5, [0, 0, 0], [0, 0, 1], 0, 0.045, 0.04, 0.05, [1.8, 0.12], [[1, 1, 1, -1]], [0.5, 1], 0, 0, "", "", "", 0, false, 0, [[0, 0, 0, 0]]];
_particle_emitter_1 setParticleRandom [0.4, [3, 3, 0.3], [0, 0, 0.519615], 10, 0.1, [0.1, 0.1, 0.1, 0], 0, 0, 0.1, 0];
_particle_emitter_1 setParticleCircle [3, [0, 0, 0]];
_particle_emitter_1 setParticleFire [1.25, 1, 0.1];
_particle_emitter_1 setDropInterval 0.008;