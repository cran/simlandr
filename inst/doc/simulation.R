## ---- include = FALSE---------------------------------------------------------
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
  par1 = list(var1 = 1),
  par2 = list(var2 = 1, var3 = 0)
)
head(single_test)

## -----------------------------------------------------------------------------
check_conv(single_test, c("out1", "out2", "out3"))

## ----eval = FALSE-------------------------------------------------------------
#  # NOT RUN
#  single_test <- bigmemory::as.big.matrix(single_test, backingfile = "single_test.bin", descriptorfile = "single_test.desc")

## ----eval = FALSE-------------------------------------------------------------
#  # NOT RUN
#  single_test <- bigmemory::attach.big.matrix("single_test")

## ----eval = FALSE-------------------------------------------------------------
#  # NOT RUN
#  single_test <- as.hash_big.matrix(single_test)
#  single_test <- attach.hash_big.matrix(single_test)

## -----------------------------------------------------------------------------
## Step 1: create a variable set
batch_test <- new_var_set()

## Step 2: add variable and its starting, end, and increment values of the sequence (passed to `seq()`) to the set.
batch_test <- batch_test %>%
  add_var("par2", "var3", 0, 0.5, 0.1)

## Step 3: make variable grids
batch_test_grid <- make_var_grid(batch_test)


## ----eval = FALSE-------------------------------------------------------------
#  # NOT RUN
#  batch_test_result <- batch_simulation(batch_test_grid, sim_fun_test,
#    default_list = list(
#      par1 = list(var1 = 0),
#      par2 = list(var2 = 0, var3 = 0)
#    )
#  )
#  
#  batch_test_result <- attach_all_matrices(batch_test_result)

## -----------------------------------------------------------------------------
batch_test_result <- batch_simulation(batch_test_grid, sim_fun_test,
  default_list = list(
    par1 = list(var1 = 0),
    par2 = list(var2 = 0, var3 = 0)
  ),
  bigmemory = FALSE
)

## -----------------------------------------------------------------------------
print(batch_test_result)
print(tibble::as_tibble(batch_test_result))

