## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
is_pkgdown <- identical(Sys.getenv("IN_PKGDOWN"), "true")

## ----setup--------------------------------------------------------------------
library(simlandr)

## -----------------------------------------------------------------------------
single_test <- sim_fun_test(
  arg1 = list(ele1 = 1),
  arg2 = list(ele2 = 1, ele3 = 0)
)

## -----------------------------------------------------------------------------
l_single_2d <- make_2d_static(single_test, x = "out1")
plot(l_single_2d)

## -----------------------------------------------------------------------------
l_single_3d <- make_3d_static(single_test, x = "out1", y = "out2")

## ----eval=is_pkgdown----------------------------------------------------------
# # This chunk will only run when building with pkgdown
# plot(l_single_3d, 1)

## -----------------------------------------------------------------------------
plot(l_single_3d, 2)

## ----eval=is_pkgdown----------------------------------------------------------
# # This chunk will only run when building with pkgdown
# l_single_4d <- make_4d_static(single_test, x = "out1", y = "out2", z = "out3")
# plot(l_single_4d) %>% plotly::layout(scene = list(zaxis = list(range = c(-3, 3))))

## -----------------------------------------------------------------------------
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
batch_test_result

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
batch_test_result2

## -----------------------------------------------------------------------------
l_batch_2d_m1 <- make_2d_matrix(batch_test_result, x = "out1", cols = "ele3")
plot(l_batch_2d_m1)

l_batch_2d_m2 <- make_2d_matrix(batch_test_result2, x = "out1", rows = "ele1", cols = "ele2")
plot(l_batch_2d_m2)

## -----------------------------------------------------------------------------
l_batch_3d_m1 <- make_3d_matrix(batch_test_result, x = "out1", y = "out2", cols = "ele3")
plot(l_batch_3d_m1)

l_batch_3d_m2 <- make_3d_matrix(batch_test_result2, x = "out1", y = "out2", rows = "ele1", cols = "ele2")
plot(l_batch_3d_m2)

## ----eval = FALSE-------------------------------------------------------------
# l_batch_3d_a <- make_3d_animation(batch_test_result, x = "out1", y = "out2", fr = "ele3")
# 
# plot(l_batch_3d_a, 1)
# plot(l_batch_3d_a, 2)

