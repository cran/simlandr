## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(simlandr)

## -----------------------------------------------------------------------------
single_test <- sim_fun_test(
  par1 = list(var1 = 1),
  par2 = list(var2 = 1, var3 = 0)
)

l_single_2d <- make_2d_density(single_test, x = "out1", from = -2, to = 2, adjust = 1)
l_single_3d <- make_3d_static(single_test, x = "out1", y = "out2", lims = c(-3, 3, -3, 3), h = 0.01, kde_fun = "ks")

batch_test <- new_var_set()
batch_test <- batch_test %>%
  add_var("par2", "var3", 0, 0.5, 0.1)
batch_test_grid <- make_var_grid(batch_test)
batch_test_result <- batch_simulation(batch_test_grid, sim_fun_test,
  default_list = list(
    par1 = list(var1 = 0),
    par2 = list(var2 = 0, var3 = 0)
  ),
  bigmemory = FALSE
)
batch_test2 <- new_var_set()
batch_test2 <- batch_test2 %>%
  add_var("par1", "var1", -0.2, 0.2, 0.2) %>%
  add_var("par2", "var2", -0.2, 0.2, 0.2)
batch_test_grid2 <- make_var_grid(batch_test2)
batch_test_result2 <- batch_simulation(batch_test_grid2, sim_fun_test,
  default_list = list(
    par1 = list(var1 = 0),
    par2 = list(var2 = 0, var3 = 0)
  ),
  bigmemory = FALSE
)

l_batch_2d_m2 <- make_2d_matrix(batch_test_result2, x = "out1", rows = "var1", cols = "var2", from = -1, to = 1, adjust = 0.1, individual_landscape = TRUE)
l_batch_3d_m2 <- make_3d_matrix(batch_test_result2, x = "out1", y = "out2", rows = "var1", cols = "var2", lims = c(-3, 3, -3, 3), h = 0.001, kde_fun = "ks", Umax = 10, individual_landscape = TRUE)
l_batch_3d_a <- make_3d_animation(batch_test_result, x = "out1", y = "out2", fr = "var3", Umax = 20, lims = c(-3, 3, -3, 3), h = 0.002, individual_landscape = TRUE)

## -----------------------------------------------------------------------------
b_single_2d <- calculate_barrier_2d(l_single_2d, start_location_value = -2, end_location_value = 2, start_r = 0.3, end_r = 0.3)

b_single_2d$local_min_start
b_single_2d$local_min_end
b_single_2d$saddle_point

get_barrier_height(b_single_2d)

plot(l_single_2d) + get_geom(b_single_2d)

## -----------------------------------------------------------------------------
b_single_3d <- calculate_barrier_3d(l_single_3d, start_location_value = c(-2.5, -2), end_location_value = c(2.5, 0), start_r = 0.3, end_r = 0.3)
plot(l_single_3d, 2) + get_geom(b_single_3d)

## -----------------------------------------------------------------------------
b_batch_2d_m2 <- calculate_barrier_2d_batch(l_batch_2d_m2, start_location_value = -0.35, end_location_value = 0.35, start_r = 0.34, end_r = 0.34)
plot(l_batch_2d_m2) + get_geom(b_batch_2d_m2)

## -----------------------------------------------------------------------------
b_batch_3d_m2 <- calculate_barrier_3d_batch(l_batch_3d_m2, start_location_value = c(-1, -1), end_location_value = c(1, 1), start_r = 0.3, end_r = 0.3)
plot(l_batch_3d_m2) + get_geom(b_batch_3d_m2)

## -----------------------------------------------------------------------------
b_batch_3d_a <- calculate_barrier(l_batch_3d_a, start_location_value = c(0,0), end_location_value = c(2, 1), start_r = 0.3, end_r = 0.6)
plot(l_batch_3d_a, 3) + get_geom(b_batch_3d_a)

## This barrier calculation doesn't find proper local minimums for several landscapes. Specify the searching parameters per landscape manually.
## First, print a template of the data format.

make_barrier_grid_3d(batch_test_grid, start_location_value = c(0,0), end_location_value = c(2, 1), start_r = 0.3, end_r = 0.6, print_template = TRUE)

## Then, modify the parameters as you want, and send this `barrier_grid` to the barrier calculation function.
b_batch_3d_a <- calculate_barrier_3d_batch(
  l_batch_3d_a,
  make_barrier_grid_3d(batch_test_grid,
    df =
      structure(list(start_location_value = list(
        c(0, 0), c(0, 0),
        c(0, 0), c(0, 0), c(0, 0), c(0, 0)
      ), start_r = list(c(
        0.1,
        0.1
      ), c(0.2, 0.2), c(0.2, 0.2), c(0.3, 0.3), c(0.3, 0.3), c(
        0.3,
        0.3
      )), end_location_value = list(c(0, 0), c(
        1,
        0.5
      ), c(1, 0.5), c(1.8, 0.8), c(2, 1), c(2, 1)), end_r = c(
        0.6, 0.6,
        0.6, 0.6, 0.6, 0.6
      )), row.names = c(NA, -6L), class = c(
        "var_grid",
        "data.frame"
      ))
  )
)
plot(l_batch_3d_a, 3) + get_geom(b_batch_3d_a)

## Now it works well.

