# 1. Setup
steps <- 1:9
get_name <- function(f0, f1) { paste0("obJECT_f0_", f0, "_f1_", f1) }

# 2. Create the Full Grid 2-Step Pairs (Horizontal and Vertical)
# This generates every possible i vs i+2 jump across the entire 9x9 grid
diff_trials <- data.frame()

anchor_steps <- c(1, 5, 9)

for (i in anchor_steps) {
  # Horizontal jumps (F0 changing) at levels of F1
  h_step_1 <- steps[1:7]
  h_step_2 <- steps[3:9]
  
  horiz <- data.frame(
    stim1 = get_name(h_step_1, i),
    stim2 = get_name(h_step_2, i),
    f0 = paste(h_step_1, ",", h_step_2),
    f1 = as.character(i),
    type = "diff_f0"
  )
  
  # Vertical jumps (F1 changing) at every level of F0
  v_step_1 <- steps[1:7]
  v_step_2 <- steps[3:9]
  
  vert <- data.frame(
    stim1 = get_name(i, v_step_1),
    stim2 = get_name(i, v_step_2),
    f0 = as.character(i),
    f1 = paste(v_step_1, ",", v_step_2),
    type = "diff_f1"
  )
  
  diff_trials <- rbind(diff_trials, horiz, vert)
}

# 3. MIRRORING (Mirror every "Different" pair to remove Order Bias)
diff_rev <- diff_trials
diff_rev$stim1 <- diff_trials$stim2
diff_rev$stim2 <- diff_trials$stim1
# (Keep the f0/f1 labels the same for analysis)

# 4. SAME TRIALS (Full Coverage)
# We test "Same" for a representative sample of the grid (all 81 points is too much)
# Let's do same trials for all steps on the 3 main tracks (1, 5, 9)
same_indices <- c(1, 5, 9)
same_trials <- data.frame()

for (i in same_indices) {
  for (j in anchor_steps) {
    # Horizontal same
    s_h <- data.frame(stim1=get_name(j, i), stim2=get_name(j, i), f0=j, f1=i, type="same")
    # Vertical same
    s_v <- data.frame(stim1=get_name(i, j), stim2=get_name(i, j), f0=i, f1=j, type="same")
    same_trials <- rbind(same_trials, s_h, s_v)
  }
}

# 5. Combine everything
testable_df <- rbind(diff_trials, diff_rev, same_trials)

write.csv(testable_df, "full_discrimination_task.csv", row.names = FALSE)