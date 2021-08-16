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

## -----------------------------------------------------------------------------
l_single_2d <- make_2d_density(single_test, x = "out1", from = -2, to = 2, adjust = 1)
plot(l_single_2d)

## -----------------------------------------------------------------------------
l_single_3d <- make_3d_static(single_test, x = "out1", y = "out2", lims = c(-3, 3, -3, 3), h = 0.01, kde_fun = "ks")

plot(l_single_3d, 1)

plot(l_single_3d, 2)

## -----------------------------------------------------------------------------
l_single_4d <- make_4d_static(single_test, x = "out1", y = "out2", z = "out3", lims = c(-3, 3, -3, 3, -3, 3), h = 0.01)
plot(l_single_4d) %>% plotly::layout(scene = list(zaxis = list(range = c(-3, 3))))

## -----------------------------------------------------------------------------
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
batch_test_result

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
batch_test_result2

## -----------------------------------------------------------------------------
l_batch_2d_m1 <- make_2d_matrix(batch_test_result, x = "out1", cols = "var3", from = -3, to = 3, adjust = 0.1)
plot(l_batch_2d_m1)

l_batch_2d_m2 <- make_2d_matrix(batch_test_result2, x = "out1", rows = "var1", cols = "var2", from = -1, to = 1, adjust = 0.1)
plot(l_batch_2d_m2)

## -----------------------------------------------------------------------------
l_batch_3d_m1 <- make_3d_matrix(batch_test_result, x = "out1", y = "out2", cols = "var3", lims = c(-3, 3, -3, 3), h = 0.001, kde_fun = "ks", Umax = 10)
plot(l_batch_3d_m1)

l_batch_3d_m2 <- make_3d_matrix(batch_test_result2, x = "out1", y = "out2", rows = "var1", cols = "var2", lims = c(-3, 3, -3, 3), h = 0.001, kde_fun = "ks", Umax = 10)
plot(l_batch_3d_m2)

## ----eval = FALSE-------------------------------------------------------------
#  l_batch_3d_a <- make_3d_animation(batch_test_result, x = "out1", y = "out2", fr = "var3", Umax = 20, lims = c(-3, 3, -3, 3), h = 0.002)
#  
#  plot(l_batch_3d_a, 1)
#  plot(l_batch_3d_a, 2)
#  plot(l_batch_3d_a, 3)

