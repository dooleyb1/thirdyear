struct sphere {
  double centre_x;
  double centre_y;
  double centre_z;
  double radius;
}

int detect_collisions(struct sphere *spheres, int *collisions, int num_spheres){
  int i;
  int j=0;

  /* Loop over each spehere */
  #pragma omp parallel for
  for(i=0; i<num_spheres; i++){

    /* Choose one sphere and compare it to the rest */
    struct sphere sphere_a = spheres[i];

    #pragma omp parallel for
    for(int x=i+1; x<num_spheres; x++){

      struct sphere sphere_b = spheres[x];

      /* Calculate distance between the two centres */
      double radii = sphere_a.radius + sphere_b.radius;
      double first_bracket = (sphere_a.x-sphere_b.x) * (sphere_a.x-sphere_b.x);
      double second_bracket = (sphere_a.y-sphere_b.y) * (sphere_a.y-sphere_b.y);
      double third_bracket = (sphere_a.z-sphere_b.z) * (sphere_a.z-sphere_b.z);

      double total = first_bracket + second_bracket + third_bracket;
      double distance = sqrt(total);

      /* Check if collision has occurred */
      if(distance < radii){
        /* Only let one thread update collisions array at a time */
        #pragma omp critical
        {
          collisions[j] = i;
          collisions[j+1] = x;
          j = j + 2;
        }
      }
    }
  }
}
