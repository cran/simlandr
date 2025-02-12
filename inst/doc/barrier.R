## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(simlandr)

## -----------------------------------------------------------------------------
single_test <- sim_fun_test(
  arg1 = list(ele1 = 1),
  arg2 = list(ele2 = 1, ele3 = 0)
)

l_single_2d <- make_2d_static(single_test, x = "out1")
l_single_3d <- make_3d_static(single_test, x = "out1", y = "out2")

batch_test <- new_arg_set()
batch_test <- batch_test %>%
  add_arg_ele("arg2", "ele3", 0.2, 0.5, 0.1)
batch_test_grid <- make_arg_grid(batch_test)
batch_test_result <- batch_simulation(batch_test_grid, sim_fun_test,
  default_list = list(
    arg1 = list(ele1 = 0),
    arg2 = list(ele2 = 0, ele3 = 0)
  ),
  bigmemory = FALSE
)
batch_test2 <- new_arg_set()
batch_test2 <- batch_test2 %>%
  add_arg_ele("arg1", "ele1", 0.2, 0.6, 0.2) %>%
  add_arg_ele("arg2", "ele2", 0.2, 0.6, 0.2)
batch_test_grid2 <- make_arg_grid(batch_test2)
batch_test_result2 <- batch_simulation(batch_test_grid2, sim_fun_test,
  default_list = list(
    arg1 = list(ele1 = 0),
    arg2 = list(ele2 = 0, ele3 = 0)
  ),
  bigmemory = FALSE
)

l_batch_3d_m1 <- make_3d_matrix(batch_test_result, x = "out1", y = "out2", cols = "ele3")
l_batch_2d_m2 <- make_2d_matrix(batch_test_result2, x = "out1", rows = "ele1", cols = "ele2", individual_landscape = TRUE)
l_batch_3d_m2 <- make_3d_matrix(batch_test_result2, x = "out1", y = "out2", rows = "ele1", cols = "ele2", Umax = 10, individual_landscape = TRUE)

## -----------------------------------------------------------------------------
b_single_2d <- calculate_barrier(l_single_2d, start_location_value = -2, end_location_value = 2, start_r = 1, end_r = 1)

b_single_2d$local_min_start
b_single_2d$local_min_end
b_single_2d$saddle_point

get_barrier_height(b_single_2d)

plot(l_single_2d) + autolayer(b_single_2d)

## -----------------------------------------------------------------------------
b_single_3d <- calculate_barrier(l_single_3d, start_location_value = c(-2.5, -2), end_location_value = c(2.5, 0), start_r = 0.3, end_r = 0.3)
plot(l_single_3d, 2) + autolayer(b_single_3d)

## -----------------------------------------------------------------------------
b_batch_2d_m2 <- calculate_barrier(l_batch_2d_m2, start_location_value = -1, end_location_value = 1, start_r = 0.99, end_r = 0.99)
plot(l_batch_2d_m2) + autolayer(b_batch_2d_m2)

## -----------------------------------------------------------------------------
b_batch_3d_m2 <- calculate_barrier(l_batch_3d_m2, start_location_value = c(-1, -1), end_location_value = c(1, 1), start_r = 0.9, end_r = 0.9)
plot(l_batch_3d_m2) + autolayer(b_batch_3d_m2)

## -----------------------------------------------------------------------------
b_batch_3d_m1 <- calculate_barrier(l_batch_3d_m1, start_location_value = c(0, 0), end_location_value = c(2, 1), start_r = 0.3, end_r = 0.6)
plot(l_batch_3d_m1) + autolayer(b_batch_3d_m1)

## This barrier calculation doesn't find proper local minimums for several landscapes. Specify the searching parameters per landscape manually.
## First, print a template of the data format.

make_barrier_grid_3d(batch_test_grid, start_location_value = c(0, 0), end_location_value = c(2, 1), start_r = 0.3, end_r = 0.6, print_template = TRUE)

## Then, modify the parameters as you want, and send this `barrier_grid` to the barrier calculation function.
b_batch_3d_m1 <- calculate_barrier(
  l_batch_3d_m1,
  make_barrier_grid_3d(batch_test_grid,
    df =
      structure(list(start_location_value = list(
        c(0, 0), c(0, 0), c(0, 0), c(0, 0)
      ), start_r = list(c(0.2, 0.2), c(0.3, 0.3), c(0.3, 0.3), c(0.3, 0.3)), end_location_value = list(c(1, 0.5), c(1.8, 0.8), c(2, 1), c(2, 1)), end_r = c(
        0.6, 0.6, 0.6, 0.6
      )), row.names = c(NA, -4L), class = c(
        "arg_grid",
        "data.frame"
      ))
  )
)
plot(l_batch_3d_m1) + autolayer(b_batch_3d_m1)

## Now it works well.

