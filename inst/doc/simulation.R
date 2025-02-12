## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(simlandr)

## -----------------------------------------------------------------------------
sim_fun_test

## -----------------------------------------------------------------------------
single_test <- sim_fun_test(
  arg1 = list(ele1 = 1),
  arg2 = list(ele2 = 1, ele3 = 0)
)
head(single_test)

## -----------------------------------------------------------------------------
check_conv(single_test, c("out1", "out2", "out3"))

## ----eval = FALSE-------------------------------------------------------------
# # NOT RUN
# single_test <- bigmemory::as.big.matrix(single_test, backingfile = "single_test.bin", descriptorfile = "single_test.desc")

## ----eval = FALSE-------------------------------------------------------------
# # NOT RUN
# single_test <- bigmemory::attach.big.matrix("single_test")

## ----eval = FALSE-------------------------------------------------------------
# # NOT RUN
# single_test <- as_hash_big.matrix(single_test)
# single_test <- attach_hash_big.matrix(single_test)

## -----------------------------------------------------------------------------
## Step 1: create a variable set
batch_test <- new_arg_set()

## Step 2: add variable and its starting, end, and increment values of the sequence (passed to `seq()`) to the set.
batch_test <- batch_test %>%
  add_arg_ele("arg2", "ele3", 0, 0.5, 0.1)

## Step 3: make variable grids
batch_test_grid <- make_arg_grid(batch_test)

## ----eval = FALSE-------------------------------------------------------------
# # NOT RUN
# batch_test_result <- batch_simulation(batch_test_grid, sim_fun_test,
#   default_list = list(
#     arg1 = list(ele1 = 0),
#     arg2 = list(ele2 = 0, ele3 = 0)
#   ),
#   bigmemory = TRUE
# )
# 
# batch_test_result <- attach_all_matrices(batch_test_result)

## -----------------------------------------------------------------------------
batch_test_result <- batch_simulation(batch_test_grid, sim_fun_test,
  default_list = list(
    arg1 = list(ele1 = 0),
    arg2 = list(ele2 = 0, ele3 = 0)
  ),
  bigmemory = FALSE
)

## -----------------------------------------------------------------------------
print(batch_test_result)
print(tibble::as_tibble(batch_test_result))

