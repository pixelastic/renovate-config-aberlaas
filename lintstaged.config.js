export default {
  '**/*.{yml,yaml}': ['yarn run lint:fix --yml'],
  '**/*.json': ['yarn run lint:fix --json'],
  '**/*.js': ['yarn run lint:fix --js'],
  '**/*.md': ['yarn run lint:fix --markdown'],
  // The Renovate validator cannot fix anything, it can only fail the commit
  'default.json': [
    () =>
      './node_modules/.bin/renovate-config-validator --strict --no-global default.json',
  ],
};
