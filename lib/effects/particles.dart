import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';

ParticleSystemComponent ringCollectEffect(Vector2 position) {
  return ParticleSystemComponent(
    position: position.clone(),
    particle: Particle.generate(
      count: 14,
      lifespan: 0.35,
      generator: (index) {
        final speed = (index + 1) * 14.0;
        return AcceleratedParticle(
          acceleration: Vector2(0, 400),
          speed: Vector2((index.isEven ? 1 : -1) * speed, -speed * 1.2),
          position: Vector2.zero(),
          child: CircleParticle(
            radius: 3,
            paint: Paint()..color = const Color(0xFFFFE08A),
          ),
        );
      },
    ),
  );
}

ParticleSystemComponent playerDeathEffect(Vector2 position) {
  return ParticleSystemComponent(
    position: position.clone(),
    particle: Particle.generate(
      count: 22,
      lifespan: 0.45,
      generator: (index) {
        final spread = (index - 11) * 18.0;
        return AcceleratedParticle(
          acceleration: Vector2(0, 520),
          speed: Vector2(spread, -220 - index * 4.0),
          position: Vector2.zero(),
          child: CircleParticle(
            radius: 4,
            paint: Paint()..color = const Color(0xFFD62839),
          ),
        );
      },
    ),
  );
}
