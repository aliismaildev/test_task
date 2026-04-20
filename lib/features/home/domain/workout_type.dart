enum WorkoutType {
  upperBody('Upper Body'),
  lowerBody('Lower Body'),
  fullBody('Full Body'),
  cardio('Cardio'),
  mobility('Mobility');

  const WorkoutType(this.label);

  final String label;
}
