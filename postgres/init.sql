CREATE TABLE IF NOT EXISTS eventos (
  id SERIAL PRIMARY KEY,
  usuario_id TEXT,
  tipo TEXT,
  materia TEXT,
  fecha DATE,
  hora TIME,
  descripcion TEXT
);

-- seed demo
INSERT INTO eventos (usuario_id, tipo, materia, fecha, hora, descripcion)
VALUES ('demo_user', 'parcial', 'Álgebra', '2025-08-19', '10:00', 'Demo: parcial Álgebra');
