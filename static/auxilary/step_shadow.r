
# Source:
# https://konradsemsch.netlify.app/2019/11/step-shadow-missing-implementing-a-custom-recipes-step-to-account-for-missing-data-patterns/


step_shadow_missing_new <-
  function(terms   = NULL,
           role    = NA,
           skip    = FALSE,
           trained = FALSE,
           prefix  = NULL, 
           columns = NULL) {
    step(
      subclass = "shadow_missing",
      terms    = terms,
      role     = role,
      skip     = skip,
      trained  = trained,
      prefix   = prefix,
      columns  = columns
    )
  }

step_shadow_missing <-
  function(recipe,
           ...,
           role    = NA,
           skip    = FALSE,
           trained = FALSE,
           prefix  = "shadow",
           columns = NULL) {
    add_step(
      recipe,
      step_shadow_missing_new(
        terms   = ellipse_check(...),
        role    = role,
        skip    = skip,
        trained = trained,
        prefix  = prefix,
        columns = columns
      )
    )
  }

prep.step_shadow_missing <- function(x,
                                     training,
                                     info = NULL,
                                     ...) {
  col_names <- terms_select(terms = x$terms, info = info)
  step_shadow_missing_new(
    terms   = x$terms,
    role    = x$role,
    skip    = x$skip,
    trained = TRUE,
    prefix  = x$prefix,
    columns = col_names
  )
}

bake.step_shadow_missing <- function(object,
                                     new_data,
                                     ...) {
  col_names <- object$columns
  for (i in seq_along(col_names)) {
    if(sum(is.na(new_data[[col_names[i]]])) > 0){ # check if column has missing data 
      col <- new_data[[col_names[i]]]
      new_data[, col_names[i]] <- col # the original column should remain
      new_data[, paste0(object$prefix, "_", col_names[i])] <- ifelse(is.na(col), 1, 0) # adding the shadowing column with a prefix 
    } else {
      next 
    }
  }
  as_tibble(new_data)
}

print.bake.step_shadow_missing <-
  function(x, width = max(20, options()$width - 30), ...) {
    cat("Creating shadow variables for ", sep = "")
    printer(x$columns, x$terms, x$trained, width = width)
    invisible(x)
  }

tidy.step_shadow_missing <- function(x, ...) {
  if (is_trained(x)) {
    res <- tibble(terms = x$columns)
  } else {
    res <- tibble(terms = sel2char(x$terms))
  }
  res
}